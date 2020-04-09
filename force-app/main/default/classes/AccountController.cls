public class AccountController {
    @AuraEnabled
    public static List<AccountWrapper> getAccout(String Accountdata){
        List<AccountWrapper> accountWrapList=new List<AccountWrapper>();
        List<Account> accountList=[Select id,name from Account];
        
        List<ID> accId=new List<ID>();
        List<ID> conAccId=new List<ID>();
        
        if(accountList!=null && accountList.size()>0){
        
            
            for(Account acc:accountList){
                accId.add(acc.Id);      //taking AccountID
            }
            
        }
        List<Account> accWCont=[Select id,name from Account where Id IN (Select AccountId From Contact) LIMIT 10];
        for(Account acclist:accWCont)
        {
            AccountWrapper accWrapWCon=new AccountWrapper(acclist,false);
            accountWrapList.add(accWrapWCon);
        }
        //System.debug('accountWrapList----'+accountWrapList);
        return accountWrapList;
        
    }
    @AuraEnabled
    public static List<ContactWrapper> showContact(String accWrapLst)
    {   
        System.debug('method show Contact called');
        List<ContactWrapper> contWrapList=new List<ContactWrapper>();
        List<AccountWrapper> accWrapperList = (List<AccountWrapper>) JSON.deserialize(accWrapLst, List<AccountWrapper>.class);
        System.debug('accWrapperList---'+accWrapperList);
        List<ID> accountIdChecked=new List<ID>();
        for(AccountWrapper accWrap:accWrapperList)
        {
            if(accWrap.checked)
            {
                accountIdChecked.add(accWrap.acc.id);
            }
            // System.debug('accountIdChecked---'+accountIdChecked);
        }
        for(Contact con:[select Id,Account.Id, Account.Name,Name,Phone,Email from Contact where Account.Id IN :accountIdChecked])
        {  
            ContactWrapper contWrapCls=new ContactWrapper(con,false);
            contWrapList.add(contWrapCls);   
        }
        return contWrapList;
    }
    
    @AuraEnabled
    public static List<Booking_Table__c> bookTable(String ConIdStr)
    {
        List<Booking_Table__c> booktblAddLst=new List<Booking_Table__c>();
        List<Booking_Table__c> booktblLstReturn=new List<Booking_Table__c>();
        List<Booking_Table__c> ContSelIdToBookTbl=new List<Booking_Table__c>();
        System.debug('in Book table method');
        //st<Id> ContID = (List<Id>)JSON.deserialize(ConWrapLst,List<Id>.class);
        String ConId=ConIdStr;
        System.debug(ConId);
        System.debug('Selected cont Id=='+ConId);
        List<ID> contactIdSelected=new List<ID>();
        decimal holdAmt=0,holdGrossAmt, holdGrossAmttemp;
        //for(ContactWrapper contSelIdLst:ContWrapperList){
        // if(contSelIdLst.isConselect)
        // {
        // contactIdSelected.add(contSelIdLst.cont.id);
        //System.debug('contactIdSelected---'+contactIdSelected);
        //}
        //System.debug('contactIdSelected---'+contactIdSelected);
        // }
        
        List<Booking_Table__c> booktblLst=[SELECT Id,Name,Contact__c,TextDescription__c,Amount__c,Is_Booking__c,Gross_Amount__c From Booking_Table__c  
                                           WHERE Contact__c =: ConId ORDER By Id Asc ];
        System.debug('Booktable Query'+booktblLst);
        if(booktblLst!=null)
        {
            for(Booking_Table__c bookAdd:booktblLst){
                if(bookAdd.Is_Booking__c==true)
                {
                    System.debug('in loop if is booking true');
                    holdGrossAmttemp=(decimal)bookAdd.Amount__c;
                    holdGrossAmt=holdGrossAmttemp+holdAmt;
                }
                if(holdGrossAmttemp!=null)
                {
                    holdAmt= holdGrossAmttemp;
                    //System.debug('holdAmt----'+holdAmt);
                    bookAdd.Gross_Amount__c=holdGrossAmt;
                    booktblAddLst.add(bookAdd);
                }
                else{
                    bookAdd.Gross_Amount__c=0;
                    booktblAddLst.add(bookAdd);
                }
                
            }
            system.debug('After adding all true'+booktblAddLst);
            update booktblAddLst;
            for(Booking_Table__c bookTblData:booktblAddLst)
            {
                booktblLstReturn.add(bookTblData);            
            }
            System.debug('Returning Method Data--'+booktblLstReturn);
            return booktblLstReturn; 
        }
        else
        { 
            return null;
            
        }
    }
    
    @AuraEnabled
    public static void saveContacts(String chkBookLst,String ConIdStr)
    {  List<Id> BookTblId=new List<Id>();
     List<Id> BookTblContactId=new List<Id>();
     
     system.debug('Inside Save Method'); 
     
     List<Booking_Table__c> BookTblLstToSave = (List<Booking_Table__c>) JSON.deserialize(chkBookLst, List<Booking_Table__c>.class);
     system.debug('BookTblLstToSave=='+BookTblLstToSave);
     if(BookTblLstToSave.size()>0 ){
         Upsert BookTblLstToSave;
         system.debug('Saving Record All List=='+BookTblLstToSave);
         for(Booking_Table__c bookTblUpd:BookTblLstToSave){
             BookTblId.add(bookTblUpd.id);
             BookTblContactId.add(bookTblUpd.Contact__c);
             // booktblUpdLst.add(bookTblUpd);
         }
         List<Booking_Table__c> BookTblDelLst=[SELECT Id,Name,Contact__c,TextDescription__c,Amount__c,Is_Booking__c,Gross_Amount__c From Booking_Table__c  
                                               WHERE (Id NOT IN :BookTblId AND Contact__c IN :BookTblContactId )];
         System.debug('Deleted List-->'+BookTblDelLst);
         if(BookTblDelLst!=null){
             System.debug('Delete ==BookTblDelLst=='+BookTblDelLst);
             delete BookTblDelLst;
         }
     }
     else{
         List<Booking_Table__c> BookTblAllDelLst=[SELECT Id,Name,Contact__c,TextDescription__c,Amount__c,Is_Booking__c,Gross_Amount__c From Booking_Table__c  
                                                  WHERE Contact__c =:ConIdStr ];
         System.debug('All Deleted-->'+BookTblAllDelLst);
         //if(BookTblDelLst!=null){
         System.debug('Delete ==BookTblDelLst=='+BookTblAllDelLst);
         delete BookTblAllDelLst;
         //system.debug('No row came to save'); 
     }
     
     
    }
    
    //---------Wrapper Class
    public class ContactWrapper{
        @AuraEnabled 
        public Contact cont;
        @AuraEnabled 
        public Boolean isConselect;
        public ContactWrapper(Contact cont,Boolean isConselect){
            this.cont=cont;
            this.isConselect=isConselect;
        }
    }
    public class AccountWrapper{
        @AuraEnabled 
        public Account acc;
        @AuraEnabled 
        public Boolean checked;
        public AccountWrapper(Account acc,Boolean checked){
            this.acc=acc;
            this.checked=checked;
        }
        
    }
    
}
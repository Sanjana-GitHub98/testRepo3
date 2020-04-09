public class ContactController {
    @AuraEnabled
    public static List<ContactWrapper> getContact(String accId)
    {   
        System.debug('method Contact called');
        List<ContactWrapper> contWrapList=new List<ContactWrapper>();
        System.debug('got Id from Salesforce'+accId);
        for(Contact con:[SELECT Id,Account.Id,Name from Contact where Account.Id =:accId])
        {  
            ContactWrapper contWrapCls=new ContactWrapper(con,false);
            contWrapList.add(contWrapCls);   
        }
        return contWrapList;
    }
    
 @AuraEnabled
  public static List<Booking_Table__c> bookTable(String ConIdStr)
    {
        system.debug('ConIdStr>>>=='+ConIdStr);
        List<Booking_Table__c> booktblAddLst=new List<Booking_Table__c>();
        List<Booking_Table__c> booktblLstReturn=new List<Booking_Table__c>();
        decimal holdAmt=0,holdAmttemp;
        if(ConIdStr!=null)
        {
            system.debug('ConIdStr=='+ConIdStr);
              List<Booking_Table__c> booktblLst=[SELECT Id,Name,Contact__c,TextDescription__c,Amount__c,Is_Booking__c,Gross_Amount__c From Booking_Table__c  
                                           WHERE Contact__c =: ConIdStr ORDER By Id Asc ];
        System.debug('Booktable Query'+booktblLst);
        if(booktblLst!=null)
        {
            for(Booking_Table__c bookAdd:booktblLst){
                if(bookAdd.Is_Booking__c==true)
                {
                    System.debug('in loop if is booking true');
                    holdAmttemp=(decimal)bookAdd.Amount__c;
                    holdAmt=holdAmttemp+holdAmt;
                }
                if(holdAmttemp!=null)
                {
                    holdAmt= holdAmttemp;
                    //System.debug('holdAmt----'+holdAmt);
                    bookAdd.Gross_Amount__c=holdAmt;
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
        else{  return null;}
        
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
         //for(Booking_Table__c bookTblUpd:BookTblLstToSave){
             //BookTblId.add(bookTblUpd.id);
             //BookTblContactId.add(bookTblUpd.Contact__c);
             // booktblUpdLst.add(bookTblUpd);
         }
         //List<Booking_Table__c> BookTblDelLst=[SELECT Id,Name,Contact__c,TextDescription__c,Amount__c,Is_Booking__c,Gross_Amount__c From Booking_Table__c  
                                               //WHERE (Id NOT IN :BookTblId AND Contact__c IN :BookTblContactId )];
        // System.debug('Deleted List-->'+BookTblDelLst);
        // if(BookTblDelLst!=null){
            // System.debug('Delete ==BookTblDelLst=='+BookTblDelLst);
             //delete BookTblDelLst;
        // }
    // }
     //else{
        // List<Booking_Table__c> BookTblAllDelLst=[SELECT Id,Name,Contact__c,TextDescription__c,Amount__c,Is_Booking__c,Gross_Amount__c From Booking_Table__c  
                                                 // WHERE Contact__c =:ConIdStr ];
        // System.debug('All Deleted-->'+BookTblAllDelLst);
         //if(BookTblDelLst!=null){
        // System.debug('Delete ==BookTblDelLst=='+BookTblAllDelLst);
         //delete BookTblAllDelLst;
         //system.debug('No row came to save'); 
    // }
     
     
    }
    
    
    //--------wrapper Class
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

}
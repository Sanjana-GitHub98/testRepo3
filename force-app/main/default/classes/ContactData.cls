public with sharing class ContactData {

@AuraEnabled(cacheable=true)
public static List<Contact> getContacts() {
    return [SELECT Id, Name ,Email, Phone, Account.Name from Contact Limit 10];
}

/*
@AuraEnabled(cacheable=true)
public static List<Booking_Table__c> getBookingData(String ConIdStr){
    List<Booking_Table__c> booktblLst=[SELECT Id,Name,Contact__c,TextDescription__c,Amount__c,Is_Booking__c,Gross_Amount__c From Booking_Table__c  
                                        WHERE Contact__c =: ConIdStr ];
                                        System.debug('booktblLst============='+booktblLst);
                                        return booktblLst;


}
*/

@AuraEnabled(cacheable=true)
public static List<Booking_Table__c> getBookingData(String ConIdStr)
{
    List<Booking_Table__c> booktblAddLst=new List<Booking_Table__c>();
    List<Booking_Table__c> booktblLstReturn=new List<Booking_Table__c>();
    List<Booking_Table__c> ContSelIdToBookTbl=new List<Booking_Table__c>();
    System.debug('in Book table method');
    String ConId=ConIdStr;
    
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
                                        WHERE Contact__c =: ConId];
    System.debug('Booktable Query'+booktblLst);
    
    // return booktblLst;

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
        return booktblAddLst;
        // update booktblAddLst;
        /* for(Booking_Table__c bookTblData:booktblAddLst)
        {
            booktblLstReturn.add(bookTblData);            
        }
        System.debug('Returning Method Data--'+booktblLstReturn);
        return booktblLstReturn; */
    }
    else
    { 
        return null;
        
    }

}


/*@AuraEnabled
public static string oncheckIsBook(){
// var isCheck = event.getSource().get("v.class");
    // alert('isCheck=='+isCheck);
    var ConSelectId=component.get("v.ContIdToBookTbl");
    var holdChkIndex=isCheck;
    var HoldOldIndxAmt=0;
    var bookDtlsLst=component.get("v.bookedList");
    var BookDtlsIndexDataChked=bookDtlsLst[parseInt(holdChkIndex)];
    //alert('BookDtlsIndexDataChked=='+BookDtlsIndexDataChked);
    if(BookDtlsIndexDataChked!=null){
        if(BookDtlsIndexDataChked.Amount__c!=null)       //Checking whether Amount Feild is empty
        {
            
            for(var i=0;i<bookDtlsLst.length;i++){
                if(bookDtlsLst[i].Is_Booking__c==true){
                    var HoldCurrIndxAmt=bookDtlsLst[i].Amount__c;
                    HoldOldIndxAmt= HoldOldIndxAmt + HoldCurrIndxAmt ;
                    //alert('HoldOldIndxAmt=='+HoldOldIndxAmt);
                }
                bookDtlsLst[i].Gross_Amount__c = parseInt(HoldOldIndxAmt);
                
            }
            //BookDtlsIndexDataChked.Gross_Amount__c = parseInt(HoldOldIndxAmt);
            BookDtlsIndexDataChked.Contact__c=ConSelectId;
            component.set("v.bookedList",bookDtlsLst);
            
        }
        else
        {
            alert('Amount Is required');
        }
    }
    else
    {alert('No Row present');}
    }
}

}*/


@AuraEnabled(cacheable=true)
public static void saveContacts(String chkBookLst,String ConIdStr)
{  List<Id> BookTblId=new List<Id>();
    List<Id> BookTblContactId=new List<Id>();
    
    system.debug('Inside Save Method'); 
    
    List<Booking_Table__c> BookTblLstToSave = (List<Booking_Table__c>) JSON.deserialize(chkBookLst, List<Booking_Table__c>.class);
    system.debug('BookTblLstToSave=='+BookTblLstToSave);
    if(BookTblLstToSave.size()>0 ){
        Upsert BookTblLstToSave;
        system.debug('Saving Record All List=='+BookTblLstToSave);
    
}


//--------wrapper Class
/*
    public class ContactWrapper{
    @AuraEnabled 
    public Contact cont;
    @AuraEnabled 
    public Boolean isConselect;
    public ContactWrapper(Contact cont,Boolean isConselect){
        this.cont=cont;
        this.isConselect=isConselect;
    }
}*/
}
}
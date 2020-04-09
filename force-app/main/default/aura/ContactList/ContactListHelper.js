({
    createObjectData: function(component, event) {
        // get the contactList from component and add(push) New Object to List  
        var RowItemList = component.get("v.bookedList");
        RowItemList.push({
            'sobjectType': 'Booking_Table__c',
            'TextDescription__c': '',
            'Amount__c': '',
            'Is_Booking__c': '',
            'Gross_Amount__c':''
        });
        // set the updated list to attribute (contactList) again    
        component.set("v.bookedList", RowItemList);
    },
    calIsBookChkedAmount: function(component, event) {
        var isCheck = event.getSource().get("v.class");
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
    
})
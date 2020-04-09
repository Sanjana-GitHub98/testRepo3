({
    bookDetail : function(component, event, helper) {
        //component.getEvent("Task3Event2").getParams({"indexContact" : selected }).fire();
        //var getBookLstPopup =event.getParam("BookDataLst");
        
        //alert("value from popup--->"+JSON.stringify(getBookLstPopup));
        var actionBookDtl=component.get("c.bookTable");
        var bookConId=component.get("v.ContIdFromContactSel");
        
        actionBookDtl.setParams({ConIdStr : bookConId});
        actionBookDtl.setCallback(this,function(response){
            var status=response.getState();
            if(status==="SUCCESS"){
                var BookLst=response.getReturnValue(); 
                //alert('BookLst--->'+JSON.stringify(BookLst));
                //alert('check'+BookLst);
                if(BookLst==null)
                {
                    //alert(' Select atleast one Account1');
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Error Message',
                        message:'Select Atleast one Contact to proceed',
                        messageTemplate: 'Mode is pester ,duration is 5sec and Message is overrriden',
                        duration:' 5000',
                        key: 'info_alt',
                        type: 'error',
                        mode: 'pester'
                    });
                    toastEvent.fire();
                    //helper.showErrToast(component, event, helper);
                }
                else{
                    component.set("v.bookedList",BookLst);
                    var lstlength=BookLst.length;
                    component.set("v.bookLstLastIndex",lstlength);
                }
                
                
            }
            
        });
        
        $A.enqueueAction(actionBookDtl); 
        
        
        //} 
    },
    bookDataAftPop : function(component, event, helper) {
        //alert('Handler called');
        var getBookLstPopup = event.getParam("UpdBookDataLst");
        //alert('send from Event-->'+JSON.stringify(getBookLstPopup));
        component.set("v.bookedList",getBookLstPopup);
        
    },
   
    
})
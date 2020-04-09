({
    
    bookDetail : function(component, event, helper) {
        //component.getEvent("Task3Event2").getParams({"indexContact" : selected }).fire();
        //var getBookLstPopup =event.getParam("BookDataLst");
        
        //alert("value from popup--->"+JSON.stringify(getBookLstPopup));
        var actionBookDtl=component.get("c.bookTable");
        var bookConId=component.get("v.ContIdFromContactSel");
        //var getLastIndex=event.getSource().get("v.class");
        //alert("bookConId=="+bookConId);
        if(bookConId==''||bookConId==null){                                           //if contact list is empty
            alert(' Select atleast one Account');
        }
        else{
            // actionBookDtl.setParams({ConWrapLst : JSON.stringify(bookConId)});
            actionBookDtl.setParams({ConIdStr : bookConId});
            actionBookDtl.setCallback(this,function(response){
                var status=response.getState();
                if(status==="SUCCESS"){
                    var BookLst=response.getReturnValue(); 
                    component.set("v.bookedList",BookLst);
                    var lstlength=BookLst.length;
                    //alert('lstlength=='+lstlength);
                    component.set("v.bookLstLastIndex",lstlength);
                    var SaveEvtOnBook=$A.get("e.c:TK3BookLstEvent");
                    //alert('on book table JS');
                    SaveEvtOnBook.setParams({"BookDataLst" : BookLst,"LastIndx":lstlength});
                    //alert('SaveEvtOnBook==>'+JSON.stringify(SaveEvtOnBook));
                    SaveEvtOnBook.fire(); 
                }
                
            });
            
            $A.enqueueAction(actionBookDtl); 
            
        } 
    },
    bookDataAftPop : function(component, event, helper) {
        var getBookLstPopup = event.getParam("UpdBookDataLst");
        //alert('send from pop up Event-->'+JSON.stringify(getBookLstPopup));
        component.set("v.bookedList",getBookLstPopup);
        
    }
    
    
})
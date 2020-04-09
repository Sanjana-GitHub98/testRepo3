({
    doInit : function(component, event, helper) {
        
        var action=component.get("c.getAccout");
        action.setParams({Accountdata : "Accountdata" });
        action.setCallback(this,function(response){
            var status=response.getState();
            if(status==="SUCCESS"){
                var accountList=response.getReturnValue();
                component.set("v.accountList",accountList);
            }
            
            
        });
        $A.enqueueAction(action);  
    },
    displayContact : function(component, event, helper) {
        var actionContact=component.get("c.showContact");
        var accid=component.get("v.accountList");
        actionContact.setParams({accWrapLst : JSON.stringify(accid)});
        
        actionContact.setCallback(this,function(response){
            var status=response.getState();
            if(status==="SUCCESS"){
                var contLst=response.getReturnValue();
                if(contLst!='')
                { 
                    component.set("v.contactList",contLst);
                }
                else{ alert(' Select atleast one Account'); }
               }
            
            
        });
        $A.enqueueAction(actionContact); 
        //}
        
    },
    //function for Adding new Row
    addNewRow: function(component, event, helper) {
        // call the comman "createObjectData" helper method for add new Object Row to List  
        helper.createObjectData(component, event);
    },
    
       
    // function for delete the row 
    removeDeletedRow: function(component, event, helper) {
        var index = event.getSource().get("v.value");
        var AllRowsList = component.get("v.bookedList");
         AllRowsList.splice(index, 1);
        component.set("v.bookedList", AllRowsList);
        helper.calIsBookChkedAmount(component, event);
    },
    bookDetail : function(component, event, helper) {
       
        var actionBookDtl=component.get("c.bookTable");
        var bookConId=component.get("v.ContIdToBookTbl");
        if(bookConId==''){                                           //if contact list is empty
            alert(' Select atleast one Account');
        }
        else{
       // actionBookDtl.setParams({ConWrapLst : JSON.stringify(bookConId)});
       actionBookDtl.setParams({ConIdStr : bookConId});
          actionBookDtl.setCallback(this,function(response){
            var status=response.getState();
            if(status==="SUCCESS"){
                var BookLst=response.getReturnValue(); component.set("v.bookedList",BookLst); }
            
          });
        $A.enqueueAction(actionBookDtl); 
       
        }
        
         },
    //function to get contact id from Radio button Selected
    contactId: function(component, event, helper) {
        var contSelId=event.getSource().get("v.text");
        //alert('contId===>'+JSON.stringify(contSelId));
         component.set("v.ContIdToBookTbl", contSelId);
        
    },
    // function for save the Records 
    Save: function(component, event, helper) { 
        var Saveaction = component.get("c.saveContacts");
        var BookTblData=component.get("v.bookedList");
        var contSelId=component.get("v.ContIdToBookTbl");
        Saveaction.setParams({chkBookLst : JSON.stringify(BookTblData),ConIdStr:contSelId});
        Saveaction.setCallback(this, function(response) {
       var state = response.getState();
            if (state === "SUCCESS") {
                var BookLst=response.getReturnValue();
                component.set("v.bookedList",BookLst)
            }
            alert(' Changes Saved')
        });
       $A.enqueueAction(Saveaction);
        
    },
    //Function called when Amount is changed 
    onChange:function(component, event, helper){
         helper.calIsBookChkedAmount(component, event);
       
    },
    //On Event on checkbox(IsBooking) Adding All Amount
    onCheck: function(component, event, helper) {
        helper.calIsBookChkedAmount(component, event);
        
        
    } 
    
})
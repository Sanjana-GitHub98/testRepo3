({
    AddNewRow : function(component, event, helper){
       // fire the AddNewRowEvt Lightning Event 
        component.getEvent("AddRowEvt").fire();     
    },
    
    removeRow : function(component, event, helper){
     // fire the DeleteRowEvt Lightning Event and pass the deleted Row Index to Event parameter/attribute
       component.getEvent("DeleteRowEvt").setParams({"indexVar" : component.get("v.rowIndex") }).fire();
    }, 
    /* bookDetail : function(component, event, helper) {
        alert('In dynamic Row');
        var actionContact=component.get("c.bookTable");
        var bookid=component.get("v.contactList");
        actionContact.setParams({ContSelWrapLst : JSON.stringify(bookid)});
         actionContact.setCallback(this,function(response){
            var status=response.getState();
            if(status==="SUCCESS"){
                var BookLst=response.getReturnValue();
                component.set("v.ContactInstance",BookLst);
                
            }
            
            
        });
        $A.enqueueAction(actionContact);    
        

     }*/
  
})
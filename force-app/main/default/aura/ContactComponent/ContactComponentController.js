({
	displayContact : function(component, event, helper) {
        var actionContact=component.get("c.getContact");
        var accid=component.get("v.AccId");
        //alert("accid"+accid);
        actionContact.setParams({accId : accid});
        //actionContact.setParams({Contactdata : "Contdata" });
        actionContact.setCallback(this,function(response){
            var status=response.getState();
            if(status==="SUCCESS"){
                var contLst=response.getReturnValue();
                 component.set("v.contactList",contLst);
               }
            
            
        });
        $A.enqueueAction(actionContact); 
        //}
        
    },
    
  
    //fuction to get Contact Id on Radio button
     contactId: function(component, event, helper) {
         //alert('contact selected');
        var contSelId=event.getSource().get("v.text");
        //alert('contId===>'+JSON.stringify(contSelId));
         component.set("v.ContIdToBookTbl", contSelId);
         //alert('ContIdOnEvent===>'+JSON.stringify(v.ContIdToBookTbl));
         var ContIdOnEvt=$A.get("e.c:ShowContactEvt");
                //alert('success of contact=='+ContIdOnEvt);
        ContIdOnEvt.setParams({"ContIdSel" : contSelId});
                //alert('SaveEvtOnBook==>'+JSON.stringify(SaveEvtOnBook));
        ContIdOnEvt.fire();
        
    }
})
({
	 openModel: function(component, event, helper) {
        // for Display Model,set the "isOpen" attribute to "true"
        component.set("v.isOpen", true);
         helper.AddObject(component, event);
        
    },
    
    closeModel: function(component, event, helper) {
        // for Hide/Close Model,set the "isOpen" attribute to "Fasle"  
        component.set("v.isOpen", false);
    },
    
    likenClose: function(component, event, helper) {
        // Display alert message on the click on the "Like and Close" button from Model Footer 
        // and set set the "isOpen" attribute to "False for close the model Box.
        alert('thanks for like Us :)');
        component.set("v.isOpen", false);
    },
    addNewRow: function(component, event, helper) {
        helper.AddObject(component, event);
    }, 
    saveData:function(component, event, helper){ 
        var Saveaction = component.get("c.saveContacts");
        var BookTblData=component.get("v.getbookedList");
        //alert('BookTblData AdD Popup==='+JSON.stringify(BookTblData));
        var contSelId=component.get("v.ContSelIdFromBookTbl");
         var RowLastIndex = component.get("v.LstIndex");
       //alert('RowItemList==='+RowLastIndex);
       //alert('called');
        var BookLstSetContID=BookTblData[parseInt(RowLastIndex)];
        //alert('Data check to update=='+JSON.stringify(BookLstSetContID));
        if(BookLstSetContID==undefined)
        {
            alert('Add a Row');
        }
        else{
        if(BookLstSetContID.Amount__c==null)
        {
            alert('Please enter Amount');
        }
        else{
        BookLstSetContID.Contact__c=contSelId;
         component.set("v.getbookedList",BookLstSetContID)
        Saveaction.setParams({chkBookLst : JSON.stringify(BookTblData),ConIdStr:contSelId});
        Saveaction.setCallback(this, function(response) {
       var state = response.getState();
            if (state === "SUCCESS") {
                 var cmpEvent = component.getEvent("SaveBookDataEvt");
                    cmpEvent.setParams({
                        "UpdBookDataLst": BookTblData });
                    cmpEvent.fire();
                    //alert('para set');
            }
       // SaveEvtOnBook.                
            
           alert(' Changes Saved');
            component.set("v.isOpen", false);
        });
       $A.enqueueAction(Saveaction);
       // helper.closeModel(component, event);
        
      
        }
        }
        
    }
})
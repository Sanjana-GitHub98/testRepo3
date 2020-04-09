({
    
    // function call on component Load
    doInit: function(component, event, helper) {
        // create a Default RowItem [Contact Instance] on first time Component Load
        // by call this helper function  
        //helper.createObjectData(component, event);
        helper.updateGrossAmount(component, event, helper); 
    },
    //to get the selected contact Id
    getContactId:function(component, event, helper) {
        helper.updateGrossAmount(component, event, helper);  
    },
    // function for save the Records 
    Save: function(component, event, helper) {
        // first call the helper function in if block which will return true or false.
        // this helper function check the "first Name" will not be blank on each row.
        if (helper.validateRequired(component, event)) {
            // call the apex class method for save the Contact List
            // with pass the contact List attribute to method param.  
            var action = component.get("c.saveContacts");
            var boookingList=component.get("v.bookingList");
            var contactdata=component.get("v.contactIdd");
            //alert(JSON.stringify(contactdata));
            action.setParams({
                BookingDetailsList : JSON.stringify(boookingList) , 
                ContactData: contactdata
            });
            
            // set call back 
            action.setCallback(this, function(response) {
                var state = response.getState();
                if (state === "SUCCESS") {
                    // if response if success then reset/blank the 'contactList' Attribute 
                    // and call the common helper method for create a default Object Data to Contact List 
                    // component.set("v.bookingList", []);
                    //helper.createObjectData(component, event);
                    alert('record Save');
                }
            });
            // enqueue the server side action  
            $A.enqueueAction(action);
        }
    },
    
    // function for create new object Row in Contact List 
    addNewRow: function(component, event, helper) {
        // call the comman "createObjectData" helper method for add new Object Row to List  
        helper.createObjectData(component, event);
    },
    
    AddNewRow : function(component, event, helper){
        // fire the AddNewRowEvt Lightning Event 
        component.getEvent("AddRowEvt").fire();     
    },
    removeRow : function(component, event, helper){
        //var v= parseInt(event.target.value);
        var v=event.getSource().get("v.value");
        alert(typeof(v)+">>>>>>>"+v);
        
        // fire the DeleteRowEvt Lightning Event and pass the deleted Row Index to Event parameter/attribute
        component.getEvent("DeleteRowEvt").setParams({"indexVar" : v}).fire();
        //helper.updateGrossAmount(component, event, helper);
        
    }, 
    
    //to get calculated value for booking
    updateAmount: function(component, event, helper){
        var bookedList=component.get("v.bookingList");
        // var completeList=component.get("v.ContactInstance");
        //console.log("bookedList111111>>>>>>>>>>>>>"+JSON.stringify(completeList));
        
        var index=event.getSource().get("v.name");
        //var index=selected.split('_');
        //var v="AMT_";
        
        var mydd=bookedList[parseInt(index)];
        console.log("bookedList>>>>>>>>>>>>>"+JSON.stringify(bookedList));
        if(bookedList[parseInt(index)]["Amount__c"]!=""){
            if(bookedList[parseInt(index)]["IsBooking__c"]==true){
                
                bookedList[parseInt(index)]["GrossAmount__c"]=bookedList[parseInt(index)]["Amount__c"];
            }
            else{
                bookedList[parseInt(index)]["GrossAmount__c"]=0;
                
            }
        }
        else{
            
            alert("Enter the Amount First");
        }
        //var amtTotal=0;
        // var bookedListLength=bookedList.length;
        
        helper.updateGrossAmount(component, event, helper);       
    },
    // function for delete the row 
    removeDeletedRow: function(component, event, helper) {
        var index =event.getSource().get("v.value"); 

        var AllRowsList = component.get("v.bookingList");
        AllRowsList.splice(index, 1);
        for(var v in AllRowsList)
            {
              console.log("<><><>"+v);  
            }
   
        component.set("v.bookingList", AllRowsList);

    },
    remove: function(component, evt, helper){
        var booklist= component.get("v.bookingList");
        var ind =evt.getSource().get("v.value"); 
        if(booklist!=undefined)
        {
        booklist.splice(ind,1);
        component.set("v.bookingList",booklist);
        }
       
        
},
    //following function not completed
    onBlurGetAmount: function(component, event, helper) {
        
        var bookedList=component.get("v.bookingList");
        // var completeList=component.get("v.ContactInstance");
        //console.log("bookedList111111>>>>>>>>>>>>>"+JSON.stringify(completeList));
        
        var selected=event.getSource().get("v.name");
        var index=selected.split('_');
        //var v="AMT_";
        
        var mydd=bookedList[parseInt(index[1]-1)]["Amount__c"];
        alert(index[1]-1);
        bookedList[parseInt(index[1])]=bookedList[parseInt(index[1]-1)]["Amount__c"];
        
        
    }
    
})
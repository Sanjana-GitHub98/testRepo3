({
    createObjectData: function(component, event) {
        // get the contactList from component and add(push) New Object to List  
        var RowItemList = component.get("v.bookingList");
        RowItemList.push({
            'sobjectType': 'BookingDetail__c',
            'Description__c': '',
            'Amount__c': '',
            'GrossAmount__c': ''
        });
        // set the updated list to attribute (contactList) again    
        component.set("v.bookingList", RowItemList);
    },
    
       
  
    
    
    // helper function for check if first Name is not null/blank on save  
    validateRequired: function(component, event) {
        var isValid = true;
        var allContactRows = component.get("v.bookingList");
        for (var indexVar = 0; indexVar < allContactRows.length; indexVar++) {
           // if (allContactRows[indexVar].Description__c == '') {
           //     isValid = false;
//alert('First Name Can\'t be Blank on Row Number ' + (indexVar + 1));
           // }
        }
        return isValid;
    },
    
    //update gross amount
     updateGrossAmount:function(component, event, helper)
    {
        var bookedList=component.get("v.bookingList");
        var amtTotal=0;
        var bookedListLength=bookedList.length;
        
        for(var boolst in bookedList)
        {
            
            if(boolst==0 &&  bookedList[boolst]["IsBooking__c"]==true)
            {
                //alert("Helloooo");
                amtTotal=parseInt(bookedList[boolst]["Amount__c"]);
            }
            if(boolst!=0 &&  bookedList[boolst]["IsBooking__c"]==true)
            {
                bookedList[boolst]["GrossAmount__c"]= parseInt(bookedList[boolst]["Amount__c"])+amtTotal;
                amtTotal=parseInt(bookedList[boolst]["GrossAmount__c"]);
            }
          if(boolst!=0 &&  bookedList[boolst]["IsBooking__c"]==false)
            {
                bookedList[boolst]["GrossAmount__c"]= amtTotal;
               
            }
          //  if(boolst==bookedListLength-1)  
          //  {
                //alert("End");
                
            //    break;
            //}
        } 
          component.set("v.bookingList",bookedList); 
    },
})
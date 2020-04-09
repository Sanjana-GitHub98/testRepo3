({
	 AddObject: function(component, event) {
        // get the contactList from component and add(push) New Object to List  
        var RowItemList=component.get("v.getbookedList");
         //alert('RowItemList>>>==='+JSON.stringify(RowItemList));
         if(RowItemList!=null){
         //alert('RowItemList>>>==='+JSON.stringify(RowItemList));
        RowItemList.push({
            'sobjectType': 'Booking_Table__c',
            'TextDescription__c': '',
            'Amount__c': '',
            'Is_Booking__c': '',
            'Gross_Amount__c':''
        });
        // set the updated list to attribute (contactList) again    
        component.set("v.getbookedList", RowItemList);
         }
         else{
              }
    },
    
})
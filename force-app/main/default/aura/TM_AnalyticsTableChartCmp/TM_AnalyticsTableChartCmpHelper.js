({
	
    // Fetch  Vendors, Categories and PCS data from the Apex controller getVendorsTableData
    getVendorData: function(component, event, helper) {
         var action = component.get('c.getVendorsTableData');
        
        // Set up the callback
        var self = this;
        action.setCallback(this, function(response) {
            //alert(response.getReturnValue());
            component.set('v.vendors', response.getReturnValue());
        });
        $A.enqueueAction(action);
    },
    getCategoriesData: function(component, event, helper) {
         var action = component.get('c.getCategoriesTableData');
        
        // Set up the callback
        var self = this;
        action.setCallback(this, function(response) {
            //alert(response.getReturnValue());
            component.set('v.categories', response.getReturnValue());
        });
        $A.enqueueAction(action);
    },
        getPSCData: function(component, event, helper) {
         var action = component.get('c.getPscTableData');
        
        // Set up the callback
        var self = this;
        action.setCallback(this, function(response) {
            //alert(response.getReturnValue());
            component.set('v.pscs', response.getReturnValue());
        });
        $A.enqueueAction(action);
    }
})
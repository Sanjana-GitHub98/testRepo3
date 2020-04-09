({
    doInit : function(component, event, helper) {
        //Fetch all Vendors, Categories and PCS data
        helper.getVendorData(component, event, helper);	
        helper.getCategoriesData(component, event, helper);	
        helper.getPSCData(component, event, helper);	
    }
})
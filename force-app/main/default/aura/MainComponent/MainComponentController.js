({
    
   
	ContDataFromComp : function(component, event, helper) {
        
		var getContIdFromContCtr = event.getParam("ContIdSel");
        alert("getContId from controller--"+getContIdFromContCtr);
        component.set("v.ContIdFrmCntr",getContIdFromContCtr);
	}
})
({
	openCmp : function(component, event, helper) {
        var currentval=component.find('BtnId');
        component.set("v.clicked",true);
       //alert('value-->'+a);
      component.set("v.btnDisplay",false);
		
	}
})
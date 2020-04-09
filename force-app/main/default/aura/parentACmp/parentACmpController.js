({
	handleParentAclick : function(component, event, helper) {
		var childEvt=component.find('childCmp');
       childEvt.childA('Inside Parent method');
        
	}
})
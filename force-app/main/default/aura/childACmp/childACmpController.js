({
	handleChildA : function(component, event, helper) {
		var parentvalue=event.getParam('arguments');
        alert('->>'+parentvalue);
        var paramter1=parentvalue.varString;
        alert('from child->'+paramter1);
	}
})
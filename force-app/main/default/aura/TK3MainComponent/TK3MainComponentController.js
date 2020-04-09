({
	ContDataFromComp : function(component, event, helper) {
        
		var getContIdFromContCtr = event.getParam("ContIdSel");
        //alert("getContId from controller--"+getContIdFromContCtr);
        component.set("v.ContIdFrmCntr",getContIdFromContCtr);
	},
    
    BookDataFromComp : function(component, event, helper) {
        
		var getBookLst = event.getParam("BookDataLst");
        //alert("book list handled in Main--"+JSON.stringify(getBookLst));
        component.set("v.BookLstMain",getBookLst);
        var getLastIndx= event.getParam("LastIndx");
        component.set("v.LstIndxMain",getLastIndx);
	},
})
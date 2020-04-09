({
	doInit : function(component, event, helper) {
    },
    displayLessWhenMoreClicked: function(component, event, helper) {
    	component.set("v.buttonDisplay",1);
        
	},
   
    //Read More Collapse Functionality
    ScriptLoad:function(component, event, helper) {
        alert("in script load");
        $(function() {
		 alert("in function");
			var $el, $ps, $up, $p,$k,totalHeight;
			
			$(".sidebar-box .button").click(function() {
			
				totalHeight = 0
			// alert("in more function");
				$el = $(this);
                // alert("in more function1"+JSON.stringify($el));
				$p  = $el.parent();
               //  alert("in more function2"+JSON.stringify($p));
				$up = $p.parent();
				$ps = $up.find("p:not('.read-more')");
				
				// measure how tall inside should be by adding together heights of all inside paragraphs (except read-more paragraph)
				$ps.each(function() {
					totalHeight += $(this).outerHeight();
					// FAIL totalHeight += $(this).css("margin-bottom");
				});
							
				$up
					.css({
						// Set height to prevent instant jumpdown when max height is removed
						"height": $up.height(),
						"max-height": 9999
					})
					.animate({
						"height": totalHeight
					});
				
				// fade out read-more
				$p.fadeOut();
				
				// prevent jump-down
				return false;
					
			});
            $(".sidebar-lessbox .buttonless").click(function() {
       		   alert("less button clicked");
			 component.set("v.buttonDisplay",0);
				$el = $(this);
                // alert("in more function1"+JSON.stringify($el));
				$p  = $el.parent();
               //  alert("in more function2"+JSON.stringify($p));
				$up = $p.parent();
				$ps = $up.find("p:not('.read-less')");
				
				// measure how tall inside should be by adding together heights of all inside paragraphs (except read-more paragraph)
				$ps.each(function() {
					totalHeight = 130;
					// FAIL totalHeight += $(this).css("margin-bottom");
				});
							
				$up
					.css({
						// Set height to prevent instant jumpdown when max height is removed
						"height": $up.height(),
						"max-height": 500
					})
					.animate({
						"height": totalHeight
					});
				
            });
		
		});
    }
})
({    
    relatedToContact : function(component) {
        var action = component.get("c.getRelatedWI");
        
        action.setParams({
            r : component.get("v.recordId")
        });
        
        action.setCallback(this, function(a) {
            if (a.getState() === "SUCCESS") {
                component.set("v.workItems", a.getReturnValue());
            } else if (a.getState() === "ERROR") {
                $A.log("Errors", a.getError());
            }
        });
        
        $A.enqueueAction(action);
    }
})
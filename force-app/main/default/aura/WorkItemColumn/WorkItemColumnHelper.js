({    
    putColumnStatus : function(component) {
        var action = component.get("c.getWorkItem");
        
        action.setParams({
            s : component.get("v.columnStatus")
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
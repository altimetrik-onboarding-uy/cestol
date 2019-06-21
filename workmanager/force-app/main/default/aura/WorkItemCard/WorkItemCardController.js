({
    workIcon : function(component, event, helper) {
        var cardType = component.get("v.workItem.Type__c")
        
        if(cardType == "Idea"){
            component.set("v.iconType","action:description");
        }else if(cardType == "Action"){
            component.set("v.iconType","action:fallback");
        }else if(cardType == "Fix"){
            component.set("v.iconType","action:canvas");
        }else{
            return null;
        }
    },
    
    editRecord : function (component, event, helper){
        var editRecordEvent = $A.get("e.force:editRecord");
        editRecordEvent.setParams({
            "recordId": component.get("v.workItem.Id")
        });
        editRecordEvent.fire();
    },
    
    openRecord : function (component, event, helper) {
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
            "recordId": component.get("v.workItem.Id")
        });
        navEvt.fire();
    },
})
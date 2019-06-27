({
    workIcon : function(component, event, helper) {
        var cardType = component.get("v.workItem.Type__c")
        
        switch(cardType) {
            case "Idea":
                component.set("v.iconType","action:description");
                break;
            case "Action":
                component.set("v.iconType","action:fallback");
                break;
            case "Fix":
                component.set("v.iconType","action:canvas");
                break;
            default:
                component.set("v.iconType","utility:error");
        }
    },
    
    editRecordHelper : function (component, event, helper){
        var editRecordEvent = $A.get("e.force:editRecord");
        editRecordEvent.setParams({"recordId": component.get("v.workItem.Id")});
        editRecordEvent.fire();
    },
    
    openRecordHelper : function (component, event, helper) {
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({"recordId": component.get("v.workItem.Id")});
        navEvt.fire();
    },
})
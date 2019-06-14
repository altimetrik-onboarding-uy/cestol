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
    
    openRecord : function (component, event, helper){
        var editRecordEvent = $A.get("e.force:editRecord");
        editRecordEvent.setParams({
            "recordId": component.get("v.workItem.Id")
        });
        editRecordEvent.fire();
    },
    /*renderStatus : function (component, event, helper){
        var cStat = component.get("v.cardStatus");
        var wStat = component.get("v.workItem.Status__c");
        var cDate = component.get("v.workItem.CreatedDate");
        
        if (cStat == wStat && cDate+30>Today()){
            return true;
        }else{
            return null;
        }
    },*/
})
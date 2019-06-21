public with sharing class WorkItemPanelController {
    
    @AuraEnabled
    public static List<Work_Item__c> getWorkItem(String s){
        List<Work_Item__c> filtStatus = 
            [SELECT Id, Name, Title__c, Description__c, Difficulty_Level__c, Status__c, Type__c, CreatedDate, Estimated_Date__c, Assigned_To__r.Name 
             FROM Work_Item__c 
             WHERE CreatedDate = LAST_N_DAYS:30 
             AND Status__c = : s];
        
        return filtStatus;
    }
    
    @AuraEnabled
    public static List<Work_Item__c> getRelatedWI(String r){
        List<Work_Item__c> relatedWI = [SELECT Id, Name, Title__c, Status__c, Type__c, Assigned_To__r.Id, Estimated_Date__c 
                                        FROM Work_Item__c 
                                        WHERE Assigned_To__r.Id = : r AND Status__c != : 'Done'];
        return relatedWI;
    }
}
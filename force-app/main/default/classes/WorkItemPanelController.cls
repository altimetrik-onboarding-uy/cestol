public with sharing class WorkItemPanelController {
    
    @AuraEnabled
    public static List<Work_Item__c> getWorkItem(String s){
        List<Work_Item__c> filtStatus = 
            [SELECT Id, Name, Title__c, Description__c, Difficulty_Level__c, Status__c, Type__c, CreatedDate 
             FROM Work_Item__c 
             WHERE CreatedDate = LAST_N_DAYS:30 
             AND Status__c = : s];
        
        return filtStatus;
    }
}
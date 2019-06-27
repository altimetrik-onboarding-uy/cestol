@isTest
private class testWorkItemPanelController {
    
    @testSetup
    static void setup(){
        //Insert Contact
        Contact c = new Contact(LastName = 'Test Contact Name');
        insert c;
        
        //Insert Work Items
        List<Work_Item__c> wiList = new List<Work_Item__c>();
        for (Integer i=0;i<5;i++) {
            wiList.add(new Work_Item__c(Title__c='New Work Item '+i, 
                                        Description__c='Description', 
                                        Status__c='New', 
                                        Type__c='Idea', 
                                        Assigned_To__c= c.Id, 
                                        Estimated_Date__c=date.today()));
        }
        for (Integer i=0;i<5;i++) {
            wiList.add(new Work_Item__c(Title__c='Ready Work Item '+i, 
                                        Description__c='Description', 
                                        Status__c='Ready', 
                                        Type__c='Fix', 
                                        Assigned_To__c= c.Id, 
                                        Estimated_Date__c=date.today()));
        }
        for (Integer i=0;i<5;i++) {
            wiList.add(new Work_Item__c(Title__c='In Progress Work Item '+i, 
                                        Description__c='Description', 
                                        Status__c='In Progress', 
                                        Type__c='Action', 
                                        Assigned_To__c= c.Id, 
                                        Estimated_Date__c=date.today()));
        }
        for (Integer i=0;i<5;i++) {
            wiList.add(new Work_Item__c(Title__c='Done Work Item '+i, 
                                        Description__c='Description', 
                                        Status__c='Done', 
                                        Type__c='Action', 
                                        Assigned_To__c= c.Id, 
                                        Estimated_Date__c=date.today()));
        }
        insert wiList;
    }
    
    static testmethod void testPanelController() {
        
        String status = 'New';
        List<Work_Item__c> results = WorkItemPanelController.getWorkItem(status);
        
        Test.startTest();
        System.AssertEquals(5, results.size(), 'Incorrect number of records returned');
        
        for(Work_Item__c r : results){
            System.Assert((r.Status__c == status), 'Returned records do not have the required status.');
        }
        Test.stopTest(); 
    }
    static testmethod void testContactPanelController() {
        
        String status = 'Done';
        Contact con = [SELECT Id, LastName FROM Contact WHERE  LastName = : 'Test Contact Name' LIMIT 1];
        String IdCon = String.valueOf(con.Id);
        
        List<Work_Item__c> results = WorkItemPanelController.getRelatedWI(IdCon);
        
        Test.startTest();
        System.AssertEquals(15, results.size(), 'Incorrect number of records returned');
        
        for(Work_Item__c r : results){
            System.Assert((r.Status__c != status), 'Returned records do not have the required status.');
        }
        Test.stopTest(); 
    }
}
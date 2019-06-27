@isTest
private class testOverdue{
    //Cron expression for scheduling jobs
    public static String CRON_EXP = '0 0 0 20 7 ? 2020';
    
    @testSetup    
    static void setup(){
        //Insert Users with Admin profile
        Profile adminProfile = [SELECT Id FROM Profile WHERE Profile.Name = 'System Administrator' LIMIT 1];
        
        List<User> adminList = new List<User>();
        
        for (Integer i=0; i<5; i++) {
            
            adminList.add( new User(Username = 'TestUser'+i+'@cestolaltimetrikonboarding.com',
                                    ProfileId = adminProfile.Id,
                                    Email = 'TestUserEmail'+i+'@cestolaltimetrikonboarding.com',
                                    LastName = 'Last',
                                    CompanyName = 'TEST',
                                    Title = 'Title',
                                    Alias = 'Alias',
                                    EmailEncodingKey = 'ISO-8859-1',
                                    TimeZoneSidKey = 'America/Argentina/Buenos_Aires', 
                                    LocaleSidKey = 'en_US', 
                                    LanguageLocaleKey = 'en_US'));
        }
        
        insert adminList;     
        
        //Insert Contact to assign Work Items to
        Contact c = new Contact(LastName = 'Test Contact Name');
        insert c;
        
        //Insert Work Item records with assigned contact
        List<Work_Item__c> wiList = new List<Work_Item__c>();
        for (Integer i=0;i<5;i++) {
            wiList.add(new Work_Item__c(Title__c='WI not overdue '+i, 
                                        Description__c='Description', 
                                        Status__c='New', 
                                        Type__c='Idea', 
                                        Assigned_To__c= c.Id, 
                                        Estimated_Date__c=date.today()+1));
        }
        for (Integer i=0;i<5;i++) {
            wiList.add(new Work_Item__c(Title__c='WI overdue today '+i, 
                                        Description__c='Description', 
                                        Status__c='New', 
                                        Type__c='Fix', 
                                        Assigned_To__c= c.Id, 
                                        Estimated_Date__c=date.today()));
        }
        for (Integer i=0;i<5;i++) {
            wiList.add(new Work_Item__c(Title__c='WI overdue past '+i, 
                                        Description__c='Description', 
                                        Status__c='New', 
                                        Type__c='Action', 
                                        Assigned_To__c= c.Id, 
                                        Estimated_Date__c=date.today()-3));
        }
        insert wiList;
    }
    // Test Method for overdue process
    static testmethod void testOverdue() {        
        
        Test.startTest();
        
        OverdueScheduler os = new OverdueScheduler();
        String jobId = System.schedule('ScheduledApexTest', CRON_EXP, os);
        
        Test.stopTest();
    }
}
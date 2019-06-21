@isTest
private class testOverdue{
    public static String CRON_EXP = '0 0 0 20 6 ? 2019';
    @testSetup
    
    
    static void setup(){
        List<Work_Item__c> wiList = new List<Work_Item__c>();
        
        for (Integer i=0;i<10;i++) {
            wiList.add(new Work_Item__c(Title__c='WI not overdue '+i, 
                                        Description__c='Description', 
                                        Status__c='New', 
                                        Type__c='Idea', 
                                        Assigned_To__c='003L000000ybjqEIAQ', 
                                        Estimated_Date__c=date.today()+1)
                      );
        }
        for (Integer i=0;i<10;i++) {
            wiList.add(new Work_Item__c(Title__c='WI overdue today '+i, 
                                        Description__c='Description', 
                                        Status__c='New', 
                                        Type__c='Fix', 
                                        Assigned_To__c='003L000000ybjqEIAQ', 
                                        Estimated_Date__c=date.today())
                      );
        }
        for (Integer i=0;i<10;i++) {
            wiList.add(new Work_Item__c(Title__c='WI overdue past '+i, 
                                        Description__c='Description', 
                                        Status__c='New', 
                                        Type__c='Action', 
                                        Assigned_To__c='003L000000ybjqEIAQ', 
                                        Estimated_Date__c=date.today()-3)
                      );
        }
        
        insert wiList;
        
    }
    
    static testmethod void test() {        
        Test.startTest();
        String jobId = System.schedule('ScheduledApexTest', CRON_EXP, new OverdueScheduler());  
        Test.stopTest();
    }
}
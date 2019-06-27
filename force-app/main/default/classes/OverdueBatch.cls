global class OverdueBatch implements Database.Batchable<sObject>, Database.Stateful{
    
    public String query = 'SELECT Id, Name, Status__c, Title__c, Estimated_Date__c, Assigned_To__r.Name, Assigned_To__r.LastName FROM Work_Item__c WHERE Estimated_Date__c <= TODAY AND Status__c != \'Done\'';
    public String body = '';
    public String subject = '';
    
    public List<User> addresses = [SELECT Email FROM User WHERE Profile.Name = 'System Administrator' LIMIT 10];
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext bc, List<Work_Item__c> scope) {
        
        // Create Body (Should have used a template)

        String newBod = '';
        String[] myBodArray = new List<String>();
        
        for(Work_Item__c s : scope) {
            newBod = ('Name: '+s.Name+'  Status: '+s.Status__c+'  Estimated resolution date: '+s.Estimated_Date__c.format());
            myBodArray.add(newBod);
        }
        this.body = 'Dear Administrator, '+'\n'+'Here are the Work Items that are overdue today: '+'\n'+(String.join(myBodArray, ', '))+'\n'+'Regards.'+'\n';

        // Create subject
        Date subDate = date.today();
        this.subject = ('Overdue Work Items - '+subDate.format());
        
    }
    
    global void finish(Database.BatchableContext bc) {    
        // Send Email
        OverdueWIEmailManager.sendMail(this.addresses, this.subject, this.body);
    }
}
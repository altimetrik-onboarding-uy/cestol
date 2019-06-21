global class OverdueBatch implements Database.Batchable<sObject>{
    
    public String query = 'SELECT Id, Name, Status__c, Title__c, Estimated_Date__c, Assigned_To__r.Name, Assigned_To__r.LastName FROM Work_Item__c WHERE Estimated_Date__c <= TODAY AND Status__c != \'Done\'';
    global String body = '';
    global String subject = '';
    global String addresses = '';
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext bc, List<Work_Item__c> scope) {
        
        // Create Body
        String newBod = '';
        String[] myBodArray = new List<String>();
        
        for(Work_Item__c s : scope) {
            newBod = ('Name: '+s.Name+
                      '  Status: '+s.Status__c+
                      '  Estimated resolution date: '+s.Estimated_Date__c.format());
            myBodArray.add(newBod);
        }
        this.body = (String.join(myBodArray, '\n'))+'\n';
        
        // Create email Addresses
        List<User> admins = [SELECT Id, Name, Email FROM User WHERE Profile.Name = 'System Administrator'];
        String newAdd = '';
        String[] myAddArray = new List<String>();        
        
        for(User u : admins) {
            newAdd = (u.Email);
            myAddArray.add(newAdd);
        }
        this.addresses = String.join(myAddArray, '; ');
        
        // Create subject
        Date subDate = date.today();
        this.subject = ('Overdue Work Items - '+subDate.format());
        
        // Send Email
        OverdueWIEmailManager.sendMail(this.addresses, this.subject, this.body);
        
    }
    
    global void finish(Database.BatchableContext bc) {
        
    }
}
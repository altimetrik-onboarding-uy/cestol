global class OverdueWIEmailManager {
    
    //Class modified since previous version was not working for multiple users due to incorrect usage of setToAddresses().
    
    global static void sendMail(List<User> addresses, String subject, String body) {
        
        Messaging.SingleEmailMessage[] emails = new Messaging.SingleEmailMessage[0];
        
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        
        for(User u : addresses)
        {
            String[] toAddresses = new String[] {u.Email};
                email.setToAddresses(toAddresses);
            
            email.setSubject(subject);
            email.setPlainTextBody(body);
            
            emails.add(email);
        }
        
        Messaging.sendEmail(emails);
    }
    
}
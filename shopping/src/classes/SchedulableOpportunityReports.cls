public class SchedulableOpportunityReports implements Schedulable{

 public void schudule(){
   Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
          //User userObj=[select id,email,name,ContactId from user where Username=:'slv.ramaiyya@gmail.com'];
          mail.setTargetObjectId(UserInfo.getUserId());
          mail.setSenderDisplayName('Salesforce Opportunity Report');
          mail.setUseSignature(false);
          mail.setBccSender(false);
          
          EmailTemplate et=[Select id from EmailTemplate where name=:'Weekly DashBoard Alerts'];
          mail.setTemplateId(et.id);
          mail.setSaveAsActivity(false);
         

          Messaging.SendEmailResult [] r = 
    Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});  
 }
 
 
 
 

  public void execute(SchedulableContext sc)
    {
    schudule();
    }
}
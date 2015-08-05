public class RegistrationController {
    // Account Details
    public String accountName;
    public String accountEmail;
    public String accountPhone;
    public String accountUsername;
    public String accountPassword;
    
    // Outfit Details
    public String shirtSize;
    public String trouserLength;
    public String waist;
    public String outfitType;
    public String pantShape;
    public String shirtShape;
    
    public Account account{get;set;}
    public Outfit__c outfit{get;set;}
    public Request_Box__c requestBox{get;set;}
    public Opportunity newOpp{get;set;}
    public RegistrationController(ApexPages.StandardController controller) {
       account = new Account();
       outfit = new Outfit__c();
       requestBox = new Request_Box__c();
    }
                 
    public PageReference save(){
       try{
       account.Name = apexpages.currentpage().getParameters().get('accountName');
       account.Email__c = apexpages.currentpage().getParameters().get('accountEmail');
       account.Phone = apexpages.currentpage().getParameters().get('accountPhone');
       account.Username__c = apexpages.currentpage().getParameters().get('accountUsername');
       account.Password__c = apexpages.currentpage().getParameters().get('accountPassword');
       upsert account;
       
       newOpp = new Opportunity(AccountId = account.Id, Name = account.Name, CloseDate = System.today() + 90,StageName = 'Prospecting');
       upsert newOpp;
       
       outfit.Account__c = account.Id;
       outfit.Shirt_Size__c = apexpages.currentpage().getParameters().get('shirtSize');
       outfit.Trouser_Length__c = apexpages.currentpage().getParameters().get('trouserLength');
       outfit.Waist__c = apexpages.currentpage().getParameters().get('waist');
       outfit.Outfit_Type__c = apexpages.currentpage().getParameters().get('outfitType');
       outfit.Pant_Shape__c = apexpages.currentpage().getParameters().get('pantShape');
       outfit.Shirt_Shape__c = apexpages.currentpage().getParameters().get('shirtShape');
       upsert outfit;
       
       requestBox.Account__c = account.Id;
       upsert requestBox;
       }
       catch(Exception ex){
           ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'User name already exist!!!! Please Sign up with different User name'));
           return null;    
       }
       return new PageReference('/apex/Congratulation');
    }
    
    public PageReference cancel(){
       return new PageReference('/apex/Home');
    }

}
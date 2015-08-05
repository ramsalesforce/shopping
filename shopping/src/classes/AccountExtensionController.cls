global with sharing class AccountExtensionController {

    public AccountExtensionController() {

    }

    public static List<Account> accountListObj;
    
    @RemoteAction   
    global static PageReference signin(String username,String password){
        accountListObj = [SELECT id,Name,Username__c,Password__c FROM Account];
        for(Account accObj : accountListObj){
            if(accObj.Username__c == Username && accObj.Password__c == Password ){
                return new Pagereference('/apex/welcome?aid='+accObj.id);
                //return 'from ??? \'\'AccountExtensionController ';
            }else{
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Invalid Username or Password'); 
                ApexPages.addMessage(myMsg); 
            }
        }
        return null;
    }

}
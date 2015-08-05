@RestResource(urlMapping='/v1/accounts/*')
global with sharing class REST_AccountService_V1 {
    @HttpGet
    global static List<Account> doGet(){
        RestRequest req=RestContext.request;
        RestResponse res=RestContext.response;
        
        String accountId=req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        
        List<Account> results=[SELECT id, Name, Phone, Website, BillingState FROM Account];
        return results;
    }

}
@RestResource(urlMapping='/v2/accounts/*')
global with sharing class REST_AccountService_V2 {
    @httpGet
    global static WrapperAccount doGet(){
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        WrapperAccount response = new WrapperAccount();
        
        String accountId = req.requestURI.subString(req.requestURI.lastIndexOf('/')+1);
        
        List<Account> result = [SELECT Id, Name, BillingCity, Phone, Website FROM Account WHERE Id = :accountID];
        if(result != null && result.size() > 0){
            response.acct = result[0];
            response.status = 'Success';
        }else{
           	response.status = 'Fail';
            response.msg = 'account not present';
            response.acct = NULL;
            res.StatusCode = 404;
        }
        return response;                     
    }
	
    global class WrapperAccount{
        Account acct;
        String msg;
        String status;
        WrapperAccount(){}
	}
}
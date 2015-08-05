@RestResource(urlMapping='/v4/accounts/*')
global with sharing class REST_AccountService_V4 {
    @httpGet
    global static WrapperAccount doGet(){
      	RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        WrapperAccount response = new WrapperAccount();
        String accountId = req.requestURI.subString(req.requestURI.lastIndexOf('/')+1);
        if(search(accountId)){
            searchAccount(req,res,response);
        }else{
            findAccount(res,response,accountId);
        }
        return response;
    }
    
    public static boolean search(String accountId){
        if(accountId == 'accounts'){
            return true;
        }else{
            return false;
        }
    }
    
    public static void searchAccount(RestRequest req, RestResponse res, WrapperAccount response){
        String searchText = req.params.get('Name');
        if(searchText == NULL || searchText == ''){
            response.status = 'Error';
            response.msg = 'no Parameter passed to Url....';
            res.statusCode = 400;
        }else{
            String searchTerm = '%'+searchText+'%';
            List<Account> searchList = [SELECT Id, Name, Phone, Website FROM Account WHERE Name LIKE :searchTerm];
            if(searchList == NULL || searchList.size() < 0){
                response.status = 'Error';
                response.msg = 'no account is present by the given parameter';
                res.statusCode = 400;
            }else{
                response.acctList = searchList;
                response.status = 'Success';
                response.msg = 'found records';
            }
        }
    	    
    }
    
    public static void findAccount(RestResponse res,WrapperAccount response,String accountId){
        if(accountId == NULL || accountId == ''){
            response.status = 'Error';
            response.msg = 'No id passed to Url....';
            res.statusCode = 400;
        }else{
            List<Account> searchItem = [SELECT Id, Name, Phone, Website FROM Account WHERE Id = :accountId];
            response.acctList.add(searchItem[0]);
            response.msg = 'Record Found';
            response.status = 'Success';
        }
        
    }
    
    @httpPost
    global static WrapperAccount doPost(String name, String phone, String website){
    	Account acct = new Account();
        acct.Name = name;
        acct.Phone = phone;
        acct.Website = website;
        insert acct;
        WrapperAccount response = new WrapperAccount();
        response.acctList.add(acct);
        response.msg = 'new record inserted';
        response.status = 'Success';
        return response;
    }
    
    global class WrapperAccount{
        List<Account> acctList;
        String status;
        String msg;
        public WrapperAccount(){
            acctList = new List<Account>();
        }
    } 
}
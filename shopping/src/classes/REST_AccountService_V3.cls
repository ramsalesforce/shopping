@RestResource(urlMapping='/v3/accounts/*')
global with sharing class REST_AccountService_V3{
    @httpGet
    global static WrapperAccount doGet(){
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        WrapperAccount response = new WrapperAccount();
        String accountId = req.requestURI.subString(req.requestURI.lastIndexOf('/')+1);
        if(doSearch(accountId)){
           searchAccount(req,res,response); 
        }else{
           findAccount(res,response,accountId);
        }
		return response;    
    }
    
    public static boolean doSearch(String accountId){
        if(accountId == 'accounts'){
            return true;
        }else{
            return false;
        }
    }
    
    public static void searchAccount(RestRequest req,RestResponse res,WrapperAccount response) {
        String searchTerm = req.params.get('Name');
        if(searchTerm == NULL || searchTerm == '')
        {
            response.status = 'Error';
            response.msg = 'no value passed to Name';
            res.StatusCode = 400;
        }else{
            String searchText = '%'+searchTerm+'%';
            List<Account> searchList = [SELECT Id, Name, Phone, Website FROM Account Where Name Like :searchText];
            if(searchList != NULL || searchList.size() > 0){
                response.acctList = searchList;
                response.status = 'success';
                response.msg = 'records found';
            }else{
                response.status = 'Error';
                res.statusCode = 400;
            }
        }
    }
    
    public static void findAccount(RestResponse res,WrapperAccount response,String accountId){
        if(accountId != NUll || accountId != '' ){
           List<Account> result = [SELECT Id, Name, Phone, Website FROM Account WHERE Id = :accountId];
            if(result != NULL && result.size() > 0){
                response.acctList.add(result[0]);
                response.status = 'Success';
                response.msg = 'found record values';
            }else{
                response.status = 'Error';
                response.msg = 'no records found';
                res.statusCode = 400;
            }
        }else{
            response.status = 'Error';
            response.msg = 'accountId not valid';
            res.statusCode = 400;
        }
    }
    
    global class WrapperAccount{
        List<Account> acctList;
        String msg;
        String status;
        public WrapperAccount(){
            acctList = new List<Account>();
        }
    }
}
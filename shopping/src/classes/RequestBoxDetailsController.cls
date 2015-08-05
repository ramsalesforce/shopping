public class RequestBoxDetailsController {
    public Id accId{get;set;}
    public Id oId{get;set;}
    public Opportunity newOpp{get;set;}
    public Account acc{get;set;}
    public Request_Box__c requestBox{get;set;}
    public RequestBoxDetailsController(ApexPages.StandardController controller) {
        requestBox = new Request_Box__c();
        //accId = apexpages.currentpage().getparameters().get('aid');
        //acc = [SELECT id,Name,OwnerId From Account WHERE Id =: accId];
        //oId = apexpages.currentpage().getparameters().get('oid');
        //System.debug('OutfitDetailsController ------------------------------>'+accId);
        //newOpp = new Opportunity(AccountId = accId,Name = acc.Name,CloseDate = System.today() + 90,OwnerId = acc.OwnerId,StageName = 'Prospecting');
    }
    
    public PageReference save(){
        //requestBox.Account__c = accId;
        insert requestBox;
        //insert newOpp;
        return new PageReference('/apex/Congratulation');
    }
    
    public PageReference cancel(){
        return new PageReference('/apex/OutfitDetails?aid='+accId+'&oid='+oId);
    }

}
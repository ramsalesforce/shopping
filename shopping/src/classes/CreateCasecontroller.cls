public class CreateCasecontroller {
    public Case caseData{get;set;}
    //ApexPages.StandardController controller;

    public PageReference cancel() {
        return new PageReference('/apex/CreateCaseFromTemplate');
    }


    public PageReference save() {
        insert caseData;
        return new PageReference('/apex/CreateCaseFromTemplate');
    }
    public CaseTemplate__c caseTemplateObj;
    Id id;
    public CreateCasecontroller() {
        id = ApexPages.currentPage().getParameters().get('id');
        caseData = new Case(); 
        System.debug('id----------------------------------->'+id);
        caseTemplateObj = [SELECT Id,Case_Subject__c,Case_Origin__c,Description__c,Status__c,Type__c FROM CaseTemplate__c WHERE Id = :id];
        caseData.OwnerId = UserInfo.getUserId();
        //caseData.ContactId= null;
        //caseData.AccountId = null;
        //caseData.Reason =null;
        caseData.Type = caseTemplateObj.Type__c;
        caseData.Subject = caseTemplateObj.Case_Subject__c;
        caseData.Description = caseTemplateObj.Description__c;
        caseData.Status = caseTemplateObj.Status__c;
        caseData.Origin = caseTemplateObj.Case_Origin__c;   
    }

}
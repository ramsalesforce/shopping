public class DeleteTemplateController {

    Id id;
    public CaseTemplate__c caseTemplateObj;
    public DeleteTemplateController() {
        id = ApexPages.currentPage().getParameters().get('id');
        caseTemplateObj = [SELECT Id,Case_Subject__c,Case_Origin__c,Description__c,Status__c,Type__c FROM CaseTemplate__c WHERE Id = :id];
    }

    public ApexPages.StandardController controller;
    
    public DeleteTemplateController(ApexPages.StandardController controller) {
        this.controller = controller;
        
    }
    
    public PageReference remove(){
        delete caseTemplateObj;
        return new PageReference('/apex/CreateCaseFromTemplate');
    }
}
public class EditTemplateController {
    Id id;
    public CaseTemplate__c caseTemplateObj{get;set;}
    public CaseTemplate__c caseTemplate{get;set;}
    private ApexPages.StandardController controller;
    
    public EditTemplateController(ApexPages.StandardController controller) {
        this.controller = controller;
        id=ApexPages.currentPage().getParameters().get('id');
        caseTemplateObj = [SELECT id,Name,Case_Subject__c,Status__c,Case_Origin__c,Type__c,Description__c FROM CaseTemplate__c WHERE Id = :id];
        /*caseTemplate = new CaseTemplate__c();
        caseTemplate.id = caseTemplateObj.id; 
        caseTemplate.Case_Subject__c = caseTemplateObj.Case_Subject__c; 
        caseTemplate.Status__c = caseTemplateObj.Status__c;
        caseTemplate.Case_Origin__c = caseTemplateObj.Case_Origin__c;
        caseTemplate.Type__c = caseTemplateObj.Type__c;
        caseTemplate.Description__c = caseTemplateObj.Description__c; */
    }
    
    public PageReference save(){
        upsert caseTemplateObj;
        return new PageReference('/apex/CreateCaseFromTemplate');
    }
    
    public PageReference cancel(){
        return new PageReference('/apex/CreateCaseFromTemplate');
    }

}
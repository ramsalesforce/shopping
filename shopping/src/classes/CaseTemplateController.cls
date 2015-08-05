public class CaseTemplateController {
    private ApexPages.StandardController controller;
    public CaseTemplateController(ApexPages.StandardController controller) {
        this.controller = controller;
    }
    public PageReference save(){
        controller.save();
        return new PageReference('/apex/CreateCaseFromTemplate');
    }
    
    public PageReference cancel(){
        return new PageReference('/apex/CreateCaseFromTemplate');
    }
 }
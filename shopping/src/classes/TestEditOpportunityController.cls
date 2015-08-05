@isTest
public class TestEditOpportunityController {
    public testMethod static void  editOpportunityController(){
        Opportunity parentOpportunity=TestDataFactory.createOpportunity('Test Opportunity','Banking',null,'Prospecting',Date.today(),null);
        Opportunity subOpportunity=TestDataFactory.createOpportunity('Test Sub Opportunity',null,'Saving','Prospecting',Date.today(),parentOpportunity);
        ApexPages.currentPage().getParameters().put('subOppId',subOpportunity.Id);
        Test.startTest();
        EditOpportunityController controller=new EditOpportunityController(new ApexPages.StandardController(parentOpportunity));
        controller.getSubOppTypeOptions();
        controller.getStageOptions();
        controller.save();
        controller.remove();
        controller.Cancel();
        
        parentOpportunity=TestDataFactory.createOpportunity('Test Opportunity','Credit Card',null,'Prospecting',Date.today(),null);
        subOpportunity=TestDataFactory.createOpportunity('Test Sub Opportunity',null,'Visa','Prospecting',Date.today(),parentOpportunity);
        ApexPages.currentPage().getParameters().put('subOppId',subOpportunity.Id);
        controller=new EditOpportunityController(new ApexPages.StandardController(parentOpportunity));
        controller.getSubOppTypeOptions();
        controller.getStageOptions();
        controller.save();
        controller.remove();
        controller.Cancel();
        
        parentOpportunity=TestDataFactory.createOpportunity('Test Opportunity','Loan',null,'Prospecting',Date.today(),null);
        subOpportunity=TestDataFactory.createOpportunity('Test Sub Opportunity',null,'Personal','Prospecting',Date.today(),parentOpportunity);
        ApexPages.currentPage().getParameters().put('subOppId',subOpportunity.Id);
        controller=new EditOpportunityController(new ApexPages.StandardController(parentOpportunity));
        controller.getSubOppTypeOptions();
        controller.getStageOptions();
        controller.save();
        controller.remove();
        controller.Cancel();
        
        subOpportunity.Sub_Opp_Name__c ='';
        
 
        controller.save();
        Test.stopTest();
    }
}
@isTest
public class TestSubOpportunityDetailsController {
    public testMethod static void SubOpportunityDetailsController()
    {
        Opportunity parentOpportunity=TestDataFactory.createOpportunity('Test Opportunity','Banking',null,'Prospecting',Date.today(),null);
        Opportunity subOpportunity=TestDataFactory.createOpportunity('Test Sub Opportunity','Saving',null,'Prospecting',Date.today(),parentOpportunity);
        ApexPages.currentPage().getParameters().put('oppId',parentOpportunity.Id);
        ApexPages.currentPage().getParameters().put('subOppId',subOpportunity.Id);
        test.startTest();
        SubOpportunityDetailsController subOpportunities = new SubOpportunityDetailsController(new ApexPages.StandardController(parentOpportunity));
        subOpportunities.edit();
        test.stopTest();
    }
    
}
@isTest
public class TestAvoidDeletingParentOpp {
    public testMethod static void avoidDeletingParentOpp(){
        Opportunity parentOpportunity=TestDataFactory.createOpportunity('Test Opportunity','Banking',null,'Prospecting',Date.today(),null);
        Opportunity subOpportunity=TestDataFactory.createOpportunity('Test Sub Opportunity',null,'Saving','Prospecting',Date.today(),parentOpportunity);
        Test.startTest();
        parentOpportunity.Opportunity_Type__c='Credit Card';
        delete parentOpportunity;
        Test.stopTest();
    }
    
}
@isTest
public class TestPreventParentOppUpdation {
  public testMethod static void preventParentOppUpdation(){
     Opportunity parentOpportunity=TestDataFactory.createOpportunity('Test Opportunity','Banking',null,'Prospecting',Date.today(),null);
     Opportunity subOpportunity=TestDataFactory.createOpportunity('Test Sub Opportunity',null,'Saving','Prospecting',Date.today(),parentOpportunity);
     Test.startTest();
         parentOpportunity.Opportunity_Type__c='Credit Card';
         update parentOpportunity;
     Test.stopTest();
   }
}
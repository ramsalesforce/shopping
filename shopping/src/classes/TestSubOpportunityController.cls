@isTest
public class TestSubOpportunityController {
    public testMethod static void SubOpportunityController(){
    	Opportunity parentOpportunity=TestDataFactory.createOpportunity('Test Opportunity','Banking',null,'Prospecting',Date.today(),null);
     	ApexPages.currentPage().getParameters().put('id',parentOpportunity.Id);
        test.startTest();
        	SubOpportunityController subOpp = new SubOpportunityController(new ApexPages.StandardController(parentOpportunity));
        	subOpp.getSubOppTypeOptions();
        	subOpp.getStageOptions();
        	subOpp.save();
        	subOpp.cancel();
  			parentOpportunity=TestDataFactory.createOpportunity('Test Opportunity','Credit Card',null,'Prospecting',Date.today(),null);
        	ApexPages.currentPage().getParameters().put('id',parentOpportunity.Id);
        	subOpp = new SubOpportunityController(new ApexPages.StandardController(parentOpportunity));
        	subOpp.getSubOppTypeOptions();
        	subOpp.getStageOptions();
        	subOpp.save();
        	subOpp.cancel();
        	parentOpportunity=TestDataFactory.createOpportunity('Test Opportunity','Loan',null,'Prospecting',Date.today(),null);
        	ApexPages.currentPage().getParameters().put('id',parentOpportunity.Id);
        	subOpp = new SubOpportunityController(new ApexPages.StandardController(parentOpportunity));
        	subOpp.getSubOppTypeOptions();
        	subOpp.getStageOptions();
        	subOpp.save();
        	subOpp.cancel();
        	
        	parentOpportunity=TestDataFactory.createOpportunity('Test Sub Opportunity',null,'Amex','Prospecting',Date.today(),parentOpportunity);
        	ApexPages.currentPage().getParameters().put('id',parentOpportunity.Id);
        	subOpp = new SubOpportunityController(new ApexPages.StandardController(parentOpportunity));
        	subOpp.getSubOppTypeOptions();
        	subOpp.getStageOptions();
        	subOpp.save();
        	subOpp.cancel();
        
        	parentOpportunity=TestDataFactory.createOpportunity('Test Sub Opportunity',null,'Master','Prospecting',Date.today(),parentOpportunity);
        	ApexPages.currentPage().getParameters().put('id',parentOpportunity.Id);	
        	subOpp = new SubOpportunityController(new ApexPages.StandardController(parentOpportunity));
        	subOpp.getSubOppTypeOptions();
        	subOpp.getStageOptions();
        	subOpp.save();
        	subOpp.cancel();
        	
        	parentOpportunity=TestDataFactory.createOpportunity('Test Sub Opportunity',null,'Visa','Prospecting',Date.today(),parentOpportunity);
        	ApexPages.currentPage().getParameters().put('id',parentOpportunity.Id);
        	subOpp = new SubOpportunityController(new ApexPages.StandardController(parentOpportunity));
        	subOpp.getSubOppTypeOptions();
        	subOpp.getStageOptions();
        	subOpp.save();
        	subOpp.cancel();
        	
        	parentOpportunity=TestDataFactory.createOpportunity('Test Sub Opportunity',null,'Saving','Prospecting',Date.today(),parentOpportunity);
        	ApexPages.currentPage().getParameters().put('id',parentOpportunity.Id);
        	subOpp = new SubOpportunityController(new ApexPages.StandardController(parentOpportunity));
        	subOpp.getSubOppTypeOptions();
        	subOpp.getStageOptions();
        	subOpp.save();
        	subOpp.cancel();
        
        	parentOpportunity=TestDataFactory.createOpportunity('Test Sub Opportunity',null,'Checking','Prospecting',Date.today(),parentOpportunity);
        	ApexPages.currentPage().getParameters().put('id',parentOpportunity.Id);
        	subOpp = new SubOpportunityController(new ApexPages.StandardController(parentOpportunity));
        	subOpp.getSubOppTypeOptions();
        	subOpp.getStageOptions();
        	subOpp.save();
        	subOpp.cancel();
        
        	parentOpportunity=TestDataFactory.createOpportunity('Test Sub Opportunity',null,'Housing','Prospecting',Date.today(),parentOpportunity);
        	ApexPages.currentPage().getParameters().put('id',parentOpportunity.Id);
        	subOpp = new SubOpportunityController(new ApexPages.StandardController(parentOpportunity));
        	subOpp.getSubOppTypeOptions();
        	subOpp.getStageOptions();
        	subOpp.save();
        	subOpp.cancel();
        
        	parentOpportunity=TestDataFactory.createOpportunity('Test Sub Opportunity',null,'Personal','Prospecting',Date.today(),parentOpportunity);
        	ApexPages.currentPage().getParameters().put('id',parentOpportunity.Id);
        	subOpp = new SubOpportunityController(new ApexPages.StandardController(parentOpportunity));
        	subOpp.getSubOppTypeOptions();
        	subOpp.getStageOptions();
        	subOpp.save();
        	subOpp.cancel();
        	
        	parentOpportunity=TestDataFactory.createOpportunity('Test Sub Opportunity',null,'Auto','Prospecting',Date.today(),parentOpportunity);
        	ApexPages.currentPage().getParameters().put('id',parentOpportunity.Id);
        	subOpp = new SubOpportunityController(new ApexPages.StandardController(parentOpportunity));
        	subOpp.getSubOppTypeOptions();
        	subOpp.getStageOptions();
        	subOpp.save();
        	subOpp.cancel();
        
        	test.stopTest();
    }
}
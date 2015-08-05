public class SubOpportunityDetailsController {
    
    Id oppId;
    public List<Opportunity> opportunities{get;set;}
    
    public SubOpportunityDetailsController(ApexPages.StandardController controller)
    {
        oppId=ApexPages.currentPage().getParameters().get('id');
        opportunities=[select id,Sub_Opp_Name__c,StageName,CloseDate,Parent_Opportunity__c,Sub_Opp_Type__c from Opportunity where Parent_Opportunity__c=:oppId];
    }
    
    public PageReference edit()
    {
        System.debug('subOppId------------------->'+ApexPages.currentPage().getParameters().get('subOppId'));
        return new PageReference('/apex/editOpportunity?subOppId='+ApexPages.currentPage().getParameters().get('subOppId'));
    }
    
}
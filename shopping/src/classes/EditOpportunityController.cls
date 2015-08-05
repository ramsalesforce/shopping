public class EditOpportunityController {
    Id oppid,profileId;
    Profile profileObj;
    String profileName;
    public String subOppName{get;set;}
    public String subOppType{get;set;}
    public List<selectOption> subOppTypeOptions;
    public Opportunity opp{get;set;}
    public Opportunity parentOpp{get;set;}
    public String stageName{get;set;}
    public Date closeDate{get;set;}
    public List<SelectOption> stageOptions;
    
    public EditOpportunityController(ApexPages.StandardController controller)
    {
        opp=new Opportunity();
        subOppTypeOptions=new List<selectOption>();
        stageOptions=new List<SelectOption>();
        oppid=ApexPages.currentPage().getParameters().get('subOppId');
        
        System.debug('EditOpportunityController---subOppId=========='+oppId);
        opp=[select id,Sub_Opp_Name__c,StageName,CloseDate,Opportunity_Type__c,Sub_Opp_Type__c,Parent_Opportunity__c from Opportunity where id=:oppid];
        parentOpp=[select id,Opportunity_Type__c from Opportunity where id=:opp.Parent_Opportunity__c];
        this.subOppName=opp.Sub_Opp_Name__c;
        this.subOppType=opp.Sub_Opp_Type__c;
        this.closeDate=opp.CloseDate;
        this.stageName=opp.StageName;
                         
    }
    
    public List<SelectOption> getSubOppTypeOptions()
    {
        profileId=UserInfo.getProfileId();
        profileObj=[select name from Profile where id=:profileId];
        profileName=profileObj.name;
        if(parentOpp.Opportunity_Type__c=='Banking')
        {
            subOppTypeOptions.add(new SelectOption('Checking','Checking'));
            subOppTypeOptions.add(new SelectOption('Saving','Saving'));
        }
        else if(parentOpp.Opportunity_Type__c=='Credit Card')
        {
            subOppTypeOptions.add(new SelectOption('Master','Master'));
            subOppTypeOptions.add(new SelectOption('Visa','Visa'));
            subOppTypeOptions.add(new SelectOption('Amex','Amex'));
        }
        else if(parentOpp.Opportunity_Type__c=='Loan' && profileName=='Sales Person')
        {
            subOppTypeOptions.add(new SelectOption('Housing','Housing'));
            subOppTypeOptions.add(new SelectOption('Personal','Personal'));
        }
        else if(parentOpp.Opportunity_Type__c=='Loan' && profileName=='Sales Master')
        {
            subOppTypeOptions.add(new SelectOption('Auto','Auto'));
            subOppTypeOptions.add(new SelectOption('Personal','Personal'));
        }
        return subOppTypeOptions;
    }
    
    public List<SelectOption> getStageOptions(){
        stageOptions.add(new SelectOption('Prospecting','Prospecting'));
        stageOptions.add(new SelectOption('Qualification','Qualification'));
        stageOptions.add(new SelectOption('Needs Analysis','Needs Analysis'));
        stageOptions.add(new SelectOption('Value Proposition','Value Proposition'));
        stageOptions.add(new SelectOption('Id. Decision Makers','Id. Decision Makers'));
        stageOptions.add(new SelectOption('Perception Analysis','Perception Analysis'));
        stageOptions.add(new SelectOption('Proposal/Price Quote','Proposal/Price Quote'));
        stageOptions.add(new SelectOption('Negotiation/Review','Negotiation/Review'));
        stageOptions.add(new SelectOption('Closed Won','Closed Won'));
        stageOptions.add(new SelectOption('Closed Lost','Closed Lost'));
        return stageOptions;
    }

    
    public PageReference save()
    {
        try{
        opp.Sub_Opp_Name__c = subOppName;
        opp.Sub_Opp_Type__c = subOppType;
        opp.CloseDate=closeDate;
        opp.StageName=stageName;
        
        upsert opp;
        }
        catch(System.DmlException e){
        ApexPages.Message myMsg=new ApexPages.Message(ApexPages.Severity.ERROR,'Fill out all the Fields in this page!!!!!!!!!!');
        ApexPages.addMessages(e);
        }
            
        return new PageReference('/apex/SubOpportunityDetails?id='+opp.Parent_Opportunity__c);
    }
    
    public PageReference remove()
    {
        delete opp;
        return new PageReference('/apex/SubOpportunityDetails?id='+opp.Parent_Opportunity__c);
    }
    
    public PageReference Cancel()
    {
        return new PageReference('/apex/SubOpportunityDetails?id='+opp.Parent_Opportunity__c);
    }
    
}
public class SubOpportunityController {
    Id oppId,profileId;
    public Profile profileObj;
    public String profileName;
    public String subOppType{get;set;}
    public List<SelectOption> subOppTypeOptions;
    public String stageName{get;set;}
    public Date closeDate{get;set;}
    public List<SelectOption> stageOptions;
    public String subOppName{get;set;}
    public Opportunity oppObj;
    public opportunity oppSubObj{get;set;}
    public SubOpportunityController(ApexPages.StandardController controller){
        oppId=ApexPages.currentPage().getParameters().get('id');
        subOppTypeOptions=new List<SelectOption>();
        oppObj=new Opportunity();
        oppSubObj=new opportunity();
        stageOptions=new List<SelectOption>();
        oppObj=[select Name,Opportunity_Type__c,stagename,closedate,Sub_Opp_Type__c from Opportunity where id=:oppId];
        if (oppObj.Sub_Opp_Type__c!=NULL){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Not Possible to create a Sub Opportunity to a Sub Opportunity click Cancel to return previous page!!!!!!!!!'); 
            ApexPages.addMessage(myMsg);
        }
           
    }
    
    public List<SelectOption> getSubOppTypeOptions(){
        profileId=UserInfo.getProfileId();
        profileObj=[select name from Profile where id=:profileId];
        profileName=profileObj.name;
        if(oppObj.Opportunity_Type__c=='Banking'){
            subOppTypeOptions.add(new SelectOption('Checking','Checking'));
            subOppTypeOptions.add(new SelectOption('Saving','Saving'));
        }
        else if(oppObj.Opportunity_Type__c=='Credit Card'){
            subOppTypeOptions.add(new SelectOption('Master','Master'));
            subOppTypeOptions.add(new SelectOption('Visa','Visa'));
            subOppTypeOptions.add(new SelectOption('Amex','Amex'));
        }
        else if(oppObj.Opportunity_Type__c=='Loan' && profileName=='Sales Person'){
            subOppTypeOptions.add(new SelectOption('Housing','Housing'));
            subOppTypeOptions.add(new SelectOption('Personal','Personal'));
        }
        else if(oppObj.Opportunity_Type__c=='Loan' && profileName=='Sales Master'){
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
    
    public PageReference save(){ 
        try{
            oppSubObj.Name=oppObj.Name;
            oppSubObj.StageName= stageName;
            oppSubObj.CloseDate= closeDate;
            oppSubObj.Parent_Opportunity__c = oppId;
            oppSubObj.Sub_Opp_Name__c= subOppName;
            oppSubObj.Sub_Opp_Type__c=subOppType;
            upsert oppSubObj;
        }catch(System.DmlException e){
            ApexPages.addMessages(e); 
        }
        return new PageReference('/'+oppId);
        
    }
    
    public PageReference cancel(){
        return new PageReference('/'+oppId);
    }

}
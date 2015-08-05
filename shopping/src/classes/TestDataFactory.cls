@isTest
public class TestDataFactory {
    public static Opportunity createOpportunity(String name,String type,String subType,String stage,Date closeDate,Opportunity parentOppotunity){
        Opportunity opportunity = new Opportunity(Name=name,Opportunity_Type__c=type,CloseDate=closeDate,StageName=stage,Sub_Opp_Type__c=subType,Parent_Opportunity__c=(parentOppotunity==null)?null:parentOppotunity.Id);
        insert opportunity;
        return opportunity;
    }
}
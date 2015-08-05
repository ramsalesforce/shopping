trigger Stop_Changing_Sub_Opp_Parent_Opp_Type on Opportunity (before update) {
    List<Opportunity> opportunities=Trigger.new;
    Map<id,Opportunity> oldOpportunities=Trigger.oldMap;
    Map<id,Opportunity> newOpportunities=Trigger.newMap;
    for(Opportunity opportunity:opportunities){
    if(![Select Parent_Opportunity__c,Sub_Opp_Name__c,Opportunity_Type__c,Sub_Opp_Type__c from Opportunity where Parent_Opportunity__c =: opportunity.Id].isEmpty()){
            if(!oldOpportunities.get(opportunity.Id).Opportunity_Type__c.equals(newOpportunities.get(opportunity.Id).Opportunity_Type__c)){
                opportunity.addError('Not Possible to Modify Opportunity Type When it contains a Sub Opportunities!!!!!!');
                return;
            }
    }
    }
}
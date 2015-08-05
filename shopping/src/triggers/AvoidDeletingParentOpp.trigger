trigger AvoidDeletingParentOpp on Opportunity (before delete) {
    List<Opportunity> oppOld;
    for(Opportunity o:trigger.old){
        oppOld=[select id,Parent_Opportunity__c from Opportunity where Parent_Opportunity__c=: o.id];
        if(!oppOld.isEmpty()){
            o.addError('not possible to delete it contains a sub opportunity');
        }
    }
}
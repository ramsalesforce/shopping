public class OpportunityCloner{
    public Integer done{get;set;}
   public PageReference cloneOpp(){
        //try{
            System.debug('In OpportunityCloner.cloneOpp ');
            Id oppId=ApexPages.currentPage().getParameters().get('id');
           
            Boolean isRelatedItemsCloneNeeded=ApexPages.currentPage().getParameters().get('ri')=='y'?true:false;
            Opportunity opp=[SELECT Id,Name,ownerId,Amount,CloseDate,StageName FROM Opportunity WHERE Id =:oppId];
            Opportunity clonedOpp=opp.clone(false,isRelatedItemsCloneNeeded);
            clonedOpp.Name=opp.Name+' - Cloned';
            System.debug('In OpportunityCloner.cloneOpp oppId : '+oppId+' isRelatedItemsCloneNeeded '+isRelatedItemsCloneNeeded+'  opp  '+opp+' clonedOpp  '+clonedOpp);
            insert clonedOpp;
            if(isRelatedItemsCloneNeeded){
                //new OpportunityLineItem(PricebookEntryId=entry.Id, OpportunityId=Id.valueOf(oppId), UnitPrice=entry.UnitPrice, Quantity=1)
                List<OpportunityLineItem> lineItems=[SELECT Id,PricebookEntryId,OpportunityId,UnitPrice FROM OpportunityLineItem WHERE OpportunityId=:oppId];
                List<OpportunityLineItem> clonedLineItems=new  List<OpportunityLineItem>();
                OpportunityLineItem clonedLineItem=null;
                for(OpportunityLineItem lineItem : lineItems){
                    clonedLineItem=lineItem.clone(false,true);
                    clonedLineItem.PricebookEntryId=lineItem.PricebookEntryId;
                    clonedLineItem.OpportunityId=clonedOpp.Id;
                    clonedLineItem.UnitPrice=lineItem.UnitPrice;
                    clonedLineItem.Quantity=1;  
                    clonedLineItems.add(clonedLineItem);
                }
               
                System.debug('In OpportunityCloner.cloneOpp   lineItems : '+lineItems+' clonedLineItems '+clonedLineItems);
               
                if(!clonedLineItems.isEmpty()){
                    insert clonedLineItems;
                }
                List<Team__c> teams=[SELECT Name,Opportunity__c FROM Team__c WHERE Opportunity__c=:oppId];
                List<Team__c> clonedTeams=new  List<Team__c>();
                Team__c clonedTeam=null;
                for(Team__c team : teams){
                    clonedTeam=team.clone(false,true);
                    clonedTeam.Opportunity__c=clonedOpp.Id;
                    clonedTeams.add(clonedTeam);
                }
               
                System.debug('In OpportunityCloner.cloneOpp   teams : '+teams+' clonedTeams '+clonedTeams);            
               
                if(!clonedTeams.isEmpty()){
                    insert clonedTeams;
                }
               
            }
       
       	   Messaging.SingleEmailMessage email=null;
           EmailTemplate emailTemplate=null;
           email = new Messaging.SingleEmailMessage();
           email.setTargetObjectId(opp.OwnerId);
           System.debug('In OpportunityCloner.cloneOpp User Email : '+UserInfo.getUserEmail());
           email.setToAddresses(new String[]{UserInfo.getUserEmail()});
           email.setSubject('Clone complete - '+opp.Name);
           String body= 'Cloning is complete. <a href="https://ap2.salesforce.com/'+clonedOpp.Id+'">Click here</a> to view the new Opportunity';
           email.setHtmlBody(body);
           email.setSaveAsActivity(false);
           Messaging.sendEmail(new Messaging.SingleEMailMessage[]{email});
           done=1;
        //}catch(Exception ex){
          //  System.debug('Exception In OpportunityCloner.cloneOpp   '+ex.getMessage());
        //}
       return new PageReference('/'+clonedOpp.Id);
    }
}
public class GetSelectedOppController {
    public List<Opportunity> oppList {get;set;}
    private ApexPages.StandardSetController standardController;
    private Set<Id> oppIds = new Set<Id>();

    public GetSelectedOppController(ApexPages.StandardSetController standardController){
        this.standardController = standardController;
        oppList = new List<Opportunity>();
        for (Opportunity opp : (List<Opportunity>)standardController.getSelected()){ 
            oppIds.add(opp.Id);
        }
        oppList = [SELECT Name, StageName FROM Opportunity WHERE ID IN: oppIds];
    }
}
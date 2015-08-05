public class OppActController {
    public List<Opportunity> closedOppList{get;set;}
    public List<Opportunity> openOppActList{get;set;}
    public List<Opportunity> oppActList;
    public List<Opportunity> openOppNoActList{get;set;}
    public List<Opportunity> OppNoActList;
    public List<Opportunity> openOppClosedActList{get;set;}
    public List<Opportunity> OppClosedActList;
    public integer closedOppCount{get;set;}
    public integer openOppActCount{get;set;}
    public integer openOppNoActCount{get;set;}
    public integer openOppClosedActCount{get;set;}
    //opportunity opp;
    public OppActController(){
        // Closed won opportunities in last week
    	closedOppList = [SELECT id, Name, StageName, CloseDate, Account.Name FROM Opportunity WHERE StageName = 'Closed Won' AND CloseDate = LAST_WEEK];
    	closedOppCount = closedOppList.size();
        //Open opportunities if they have any open activities
        oppActList = [SELECT id,Account.Name, CloseDate, Name, StageName, (SELECT Id FROM OpenActivities) FROM Opportunity WHERE isClosed =:false];
        openOppActList = new List<Opportunity>();
        for(opportunity opp:oppActList){
            if(opp.OpenActivities.size()>0){
                openOppActList.add(opp);
            }
        }
        openOppActCount = openOppActList.size();
        
        /*openOppActList = new List<Opportunity>();
        List<opportunity> oppList = [select id,ownerid from opportunity];
        List<Task> taskList = [select id,ownerid from task where isclosed =:false ];
        for(task t:taskList){
            for(opportunity o:oppList){
                if(t.ownerid == o.ownerid )
                    opp = [Select id,ownerid,Account.Name, CloseDate, Name, StageName from opportunity where ownerid = :o.ownerid];
                	openOppActList.add(opp);
            }
        }*/
        
        
        //Open opportunities with no activities
        OppNoActList = [SELECT id,Account.Name, CloseDate, Name, StageName, (SELECT Id FROM ActivityHistories),(SELECT Id FROM OpenActivities) FROM Opportunity WHERE isClosed =:false];
        openOppNoActList = new List<Opportunity>();
        for(opportunity opp:OppNoActList){
            if(opp.ActivityHistories.size()==0 && opp.OpenActivities.size()==0){
                openOppNoActList.add(opp);
            }
        }  
        openOppNoActCount = openOppNoActList.size();
        
               
        //Open Opportunities with all Closed activities
		OppClosedActList = [SELECT id,Account.Name, CloseDate, Name, StageName, (SELECT Id FROM ActivityHistories) FROM Opportunity WHERE isClosed =:false];
        openOppClosedActList = new List<Opportunity>();
        for(opportunity opp:OppClosedActList){
            if(opp.ActivityHistories.size()>0){
                openOppClosedActList.add(opp);
            }
        } 
        openOppClosedActCount = openOppClosedActList.size();
        
    }

}
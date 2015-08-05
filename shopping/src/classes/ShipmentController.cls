public class ShipmentController {
	Id projectId;
    public String projectNumber{get;set;}
    public String contractName{get;set;}
    public Integer duration{get;set;}
    public Date startDate{get;set;}
    Project__c projectObj;
    Shipment__c shipmentObj;
    Support_Contract__c supportContractObj;
    
    public ShipmentController(){
        projectId=ApexPages.currentPage().getParameters().get('id');
        projectObj = [SELECT Id,Name FROM Project__c WHERE Id = :projectId];
        shipmentObj = new Shipment__c();
        supportContractObj = [SELECT Id, Contract_Name__c, Duration__c FROM Support_Contract__c WHERE Id =: ApexPages.currentPage().getParameters().get('cid')];
        projectNumber = projectObj.Name;
        contractName = supportContractObj.Contract_Name__c;
        duration = Integer.valueOf(supportContractObj.Duration__c);
    }
    
    public PageReference save(){
        shipmentObj.Project__c = projectObj.Id;
        shipmentObj.Support_Contract__c = ApexPages.currentPage().getParameters().get('cid');
        upsert shipmentObj;
        return new PageReference('/'+projectId);
    }
}
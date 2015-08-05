public class OtherShipmentController {
	public Id projectId;
    public String projectNumber{get;set;}
    public String shipmentType{get;set;}
    public Date startDate{get;set;}
    Project__c projectObj;
    Shipment__c shipmentObj;
    
    public OtherShipmentController(){
    	projectId=ApexPages.currentPage().getParameters().get('id');
        projectObj = [SELECT Id,Name FROM Project__c WHERE Id = :projectId];
        shipmentType=ApexPages.currentPage().getParameters().get('otherShipmentOption');
        shipmentObj = new Shipment__c();
        projectNumber = projectObj.Name;
    }
    
    public Pagereference save(){
        shipmentObj.Project__c = projectObj.Id;
        shipmentObj.Other_Shipment__c = shipmentType;
        shipmentObj.Start_Date__c = startDate;
        insert shipmentObj;
        return new PageReference('/'+projectId);
    }
    
}
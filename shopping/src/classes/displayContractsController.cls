public class displayContractsController {
    Id projectId;
    public String projectNumber{get;set;}
    public String otherShipmentOption{get;set;}
    public List<SelectOption> selectOptions;
    
    Project__c projectObj;
    Shipment__c shipmentObj;
    public List<Support_Contract__c> leftOutSupportContract{get;set;}
    public displayContractsController(){
        projectId=ApexPages.currentPage().getParameters().get('id');
        shipmentObj = new Shipment__c();
        leftOutSupportContract = new List<Support_Contract__c>();
        selectOptions = new List<SelectOption>();
        projectObj = [SELECT Id,Name FROM Project__c WHERE Id = :projectId];
        leftOutSupportContract = [SELECT Id, Name, Contract_Name__c, Duration__c FROM Support_Contract__c WHERE RecordTypeId IN (SELECT Id FROM RecordType WHERE Name = 'Hardware')  AND Id NOT IN (SELECT Support_Contract__c FROM Shipment__c)];
        projectNumber = projectObj.Name;
    }
    
    public List<SelectOption> getoptions(){
        selectOptions.add(new SelectOption('None','None'));
        selectOptions.add(new SelectOption('Miscellaneous','Miscellaneous'));
        selectOptions.add(new SelectOption('Return','Return'));
        return selectOptions;
    }
    
    public PageReference redirect(){
        return new PageReference('/apex/OtherShipment?id='+projectId+'&otherShipmentOption='+otherShipmentOption);
    }
    
    public PageReference save(){
        shipmentObj.Project__c = projectObj.Id;
        shipmentObj.Support_Contract__c = ApexPages.currentPage().getParameters().get('cid');
        return new PageReference('/apex/Shipment?id='+projectId+'&cid='+shipmentObj.Support_Contract__c);
        //upsert shipmentObj;
        //return new PageReference('/'+projectId);
    }
}
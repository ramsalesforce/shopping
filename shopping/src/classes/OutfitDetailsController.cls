public class OutfitDetailsController {
    public Outfit__c outfit{get;set;}
    public Id accId{get;set;}
    public Id oId{get;set;}
    public OutfitDetailsController(ApexPages.StandardController controller) {
        accId = apexpages.currentpage().getparameters().get('aid');
        oId = apexpages.currentpage().getparameters().get('oid');
        if(oId!=null){
           outfit = [SELECT Id,Account__c,Shirt_Size__c,Trouser_Length__c,Outfit_Type__c,Waist__c,Pant_Shape__c,Shirt_Shape__c FROM Outfit__c WHERE id = :oId];
        }else{
            outfit = new Outfit__c();
        }
    }
    
    public PageReference save(){
        outfit.Account__c = accId;
        upsert outfit;
        return new PageReference('/apex/RequestBoxDetails?aid='+accId+'&oid='+outfit.id);
    }
    
    public PageReference cancel(){
        if(oid!=null){
            return new Pagereference('/apex/RegistrationPage?aid='+accId+'&oid='+outfit.id);
        }
        else{
            return new Pagereference('/apex/RegistrationPage?aid='+accId);
        }
    }
}
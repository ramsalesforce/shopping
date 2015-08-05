public class OutfitController {
    public Id accId{get;set;}
    public String outfitType{get;set;}
    
    public OutfitController(){
        accId = apexpages.currentPage().getParameters().get('id');
    }
    
    public PageReference Oufit() {
        System.debug('OutfitController ------------------------------------>'+outfitType);
        return new PageReference('/apex/Shape');
    }

}
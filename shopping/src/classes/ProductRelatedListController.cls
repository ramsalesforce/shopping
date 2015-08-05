public class ProductRelatedListController {
    
    public Map<id,ProductWrapper> products{set;}
    public Map<id,Product2> actualProducts{get;set;}
    public Map<id,Product2> selectedProducts{get;set;}
    private ProductWrapper wrapperObj;
    public list<String> AlphaList {get; set;}
    public String AlphaFilter {get; set;}
    private Product2 QueryProduct;
    
    public Map<id,ProductWrapper> actualProductsWrapper{get;set;}
    public Product2 pro{get;set;}
    //public Boolean state{get;set;}
    public String inputText{get;set;}
    public Id oppId{get;set;}
    public string queryString;
    
    Public Integer noOfRecords{get; set;}
    Public Integer size{get;set;}
    public String pattern;
    
    
    public ProductRelatedListController(){
       oppId= ApexPages.currentPage().getParameters().get('id');
       //wrapperObj = new ProductWrapper();
       selectedProducts = new Map<id,Product2>();
       actualProducts = new Map<id,Product2>([SELECT id,Name,ProductCode,Family FROM Product2]);
       actualProductsWrapper = new Map<id,ProductWrapper>();
        for(Product2 p : actualProducts.values()){
            wrapperObj = new ProductWrapper(p,false);
            actualProductsWrapper.put(p.id,wrapperObj);
        }
        AlphaList = new list<String> {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'Other', 'All'};
        BuildQuery();
    }
    
    Public Map<id,ProductWrapper> getProducts(){
        Map<id,ProductWrapper> productList = new Map<id,ProductWrapper>();
        for(Product2 pro : (List<Product2>)setCon.getRecords()){
            wrapperObj = actualProductsWrapper.get(pro.id);
            productList.put(pro.id,wrapperObj);
        }
        return productList;
      
    }
    
    public ApexPages.StandardSetController setCon {
        get{
            if(setCon == null){
                size = 5;
                queryString = 'SELECT id,Name,ProductCode,Family FROM Product2';
                setCon = new ApexPages.StandardSetController(Database.getQueryLocator(queryString));
                setCon.setPageSize(size);
                noOfRecords = setCon.getResultSize();
            }
            return setCon;
        }set;
    }
    
   public void BuildQuery() {
        if (AlphaFilter == null || AlphaFilter.trim().length() == 0) {
            if(setCon == null){
            queryString = 'SELECT id,Name,ProductCode,Family FROM Product2';
            setCon = new ApexPages.StandardSetController(Database.getQueryLocator(queryString));
            setCon.setPageSize(size);
            noOfRecords = setCon.getResultSize();
            }
        }else if (AlphaFilter == 'All' || AlphaFilter == 'Other'){
            queryString = 'SELECT id,Name,ProductCode,Family FROM Product2';
            setCon = new ApexPages.StandardSetController(Database.getQueryLocator(queryString));
            setCon.setPageSize(size);
            noOfRecords = setCon.getResultSize();  
        }else{
            AlphaFilter = AlphaFilter + '%';
            queryString = 'SELECT id,Name,ProductCode,Family FROM Product2 WHERE Name LIKE :AlphaFilter';
            setCon = new ApexPages.StandardSetController(Database.getQueryLocator(queryString));
            setCon.setPageSize(size);
            noOfRecords = setCon.getResultSize();
        }
   }
    
    public void addProduct(){
        try{
        pro = actualProducts.get(ApexPages.currentPage().getParameters().get('pid'));
        System.debug('ProductRelatedListController  addProduct  product Name '+pro.Name);
        if(!selectedProducts.containsKey(ApexPages.currentPage().getParameters().get('pid'))){
        selectedProducts.put(ApexPages.currentPage().getParameters().get('pid'),pro);
        }else{
        selectedProducts.remove(ApexPages.currentPage().getParameters().get('pid'));
        }
        }
        catch(Exception ex){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'An Error Occured'));
            System.debug('Exception ProductRelatedListController.addProduct  '+ex.getMessage());
        }
        
    }
    
    public PageReference save(){
       List<OpportunityLineItem> oppLineItems= new List<OpportunityLineItem>();
       
       map<Id,Id> mapPriceBookList=new map<Id,Id>();
       
       for(PriceBookEntry priceBookEntryObj: [SELECT Id, Product2Id, Product2.Id, Product2.Name FROM PriceBookEntry WHERE PriceBook2.isStandard=:true]){
            mapPriceBookList.put(priceBookEntryObj.Product2.Id,priceBookEntryObj.Id);
       }
       OpportunityLineItem oppLine;
       id id=ApexPages.CurrentPage().getParameters().get('Id');
       for(Product2 p:selectedProducts.values()){
           oppLine=new OpportunityLineItem();
           oppLine.Quantity=1; 
           oppLine.PricebookEntryId=(Id)mapPriceBookList.get(p.Id);
           oppLine.OpportunityId=id;
           oppLine.TotalPrice=200;
           oppLineItems.add(oppLine);
       }
       insert oppLineItems;
       return new PageReference('/'+oppId);
    }
    
    public PageReference cancel(){
       return new PageReference('/'+oppId);
    }         
    public PageReference searchresult(){
        String search = inputText + '%';
        if(inputText != ''){
          queryString = 'SELECT id,Name,ProductCode,Family FROM Product2 WHERE Name LIKE :search';
          setCon = new ApexPages.StandardSetController(Database.getQueryLocator(queryString));
          setCon.setPageSize(size);
          noOfRecords = setCon.getResultSize();
        }else{
          queryString = 'SELECT id,Name,ProductCode,Family FROM Product2';
          setCon = new ApexPages.StandardSetController(Database.getQueryLocator(queryString));
          setCon.setPageSize(size);
          noOfRecords = setCon.getResultSize();
        }
        return null;
    }
}
public class GetTemplateList {
    public List<CaseTemplate__c> templateList{set;}
    public List<CaseTemplate__c> types{get;set;}
    public String selectedFilter{get;set;}
    public List<SelectOption> filterOptions;
    public String searchText{get;set;}
    public String searchQuery; 
    public list<String> AlphaList {get; set;}
    public String AlphaFilter {get; set;}
    
    private String sortDirection = 'ASC';
    private String sortExp = 'name';
    
    
    
    public String queryString;
    
    Public Integer noOfRecords{get; set;}
    Public Integer size{get;set;}
    
    public GetTemplateList(){
        //templateList=[SELECT id,Name,Case_Subject__c,Type__c,CreatedBy.Name,Status__c,Description__c,Case_Origin__c from CaseTemplate__c];
        AlphaList = new list<String> {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'Other', 'All'};
        BuildQuery();
        
       
    }
        
    public void BuildQuery() {
        selectedFilter='--None--';
        //setSelectedFilter();
        if (AlphaFilter == null || AlphaFilter.trim().length() == 0) {
            if(setCon == null){
                queryString = 'SELECT id,Name,Case_Subject__c,Type__c,CreatedBy.Name,Status__c,Description__c,Case_Origin__c FROM CaseTemplate__c';
                setCon = new ApexPages.StandardSetController(Database.getQueryLocator(queryString));
                setCon.setPageSize(size);
                noOfRecords = setCon.getResultSize();
            }
                 //templateList = [SELECT id,Name,Case_Subject__c,Type__c,CreatedBy.Name,Status__c,Description__c,Case_Origin__c FROM CaseTemplate__c];
        }else if (AlphaFilter == 'All' || AlphaFilter == 'Other'){
                queryString = 'SELECT id,Name,Case_Subject__c,Type__c,CreatedBy.Name,Status__c,Description__c,Case_Origin__c FROM CaseTemplate__c';
                setCon = new ApexPages.StandardSetController(Database.getQueryLocator(queryString));
                setCon.setPageSize(size);
                noOfRecords = setCon.getResultSize();
            //templateList = [SELECT id,Name,Case_Subject__c,Type__c,CreatedBy.Name,Status__c,Description__c,Case_Origin__c FROM CaseTemplate__c];
        }else{
            AlphaFilter = AlphaFilter + '%';
            queryString = 'SELECT id,Name,Case_Subject__c,Type__c,CreatedBy.Name,Status__c,Description__c,Case_Origin__c FROM CaseTemplate__c WHERE Case_Subject__c LIKE : AlphaFilter';
                setCon = new ApexPages.StandardSetController(Database.getQueryLocator(queryString));
                setCon.setPageSize(size);
                noOfRecords = setCon.getResultSize();
            //templateList = [SELECT id,Name,Case_Subject__c,Type__c,CreatedBy.Name,Status__c,Description__c,Case_Origin__c FROM CaseTemplate__c WHERE Case_Subject__c LIKE : AlphaFilter];
            
        }
   }
   
   public ApexPages.StandardSetController setCon {
        get{
            if(setCon == null){
                size = 5;
                queryString = 'SELECT id,Name,Case_Subject__c,Type__c,CreatedBy.Name,Status__c,Description__c,Case_Origin__c from CaseTemplate__c';
                setCon = new ApexPages.StandardSetController(Database.getQueryLocator(queryString));
                setCon.setPageSize(size);
                noOfRecords = setCon.getResultSize();
            }
            return setCon;
        }set;
    }
    
    public List<CaseTemplate__c> getTemplateList(){
        return (List<CaseTemplate__c>) setCon.getRecords();
    }
   
   
    public List<SelectOption> getFilterOptions(){
        Schema.DescribeFieldResult fieldResult = CaseTemplate__c.Type__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        filterOptions = new List<SelectOption>();
        filterOptions.add(new SelectOption('--None--','--None--'));
        for( Schema.PicklistEntry f : ple){
            filterOptions.add(new SelectOption(f.getLabel(), f.getValue()));
        }       
        return filterOptions;
    }
    
    public PageReference searchTextContent(){
        searchQuery = searchText + '%';
        if(String.isBlank(searchText) && selectedFilter == '--None--'){
            queryString = 'SELECT id,Name,Case_Subject__c,Type__c,CreatedBy.Name,Status__c,Description__c,Case_Origin__c from CaseTemplate__c';
            setCon = new ApexPages.StandardSetController(Database.getQueryLocator(queryString));
            setCon.setPageSize(size);
            noOfRecords = setCon.getResultSize();
            //templateList = [SELECT id,Name,Case_Subject__c,Type__c,CreatedBy.Name,Status__c,Description__c,Case_Origin__c from CaseTemplate__c];
        }else if(selectedFilter == '--None--'){
            queryString = 'SELECT id,Name,Case_Subject__c,Type__c,CreatedBy.Name,Status__c,Description__c,Case_Origin__c from CaseTemplate__c WHERE Case_Subject__c Like :searchQuery';
            setCon = new ApexPages.StandardSetController(Database.getQueryLocator(queryString));
            setCon.setPageSize(size);
            noOfRecords = setCon.getResultSize();    
            //templateList = [SELECT id,Name,Case_Subject__c,Type__c,CreatedBy.Name,Status__c,Description__c,Case_Origin__c from CaseTemplate__c WHERE Case_Subject__c Like :searchQuery];
        }else{
            queryString = 'SELECT id,Name,Case_Subject__c,Type__c,CreatedBy.Name,Status__c,Description__c,Case_Origin__c from CaseTemplate__c WHERE Type__c = :selectedFilter AND Case_Subject__c Like :searchQuery';
            setCon = new ApexPages.StandardSetController(Database.getQueryLocator(queryString));
            setCon.setPageSize(size);
            noOfRecords = setCon.getResultSize(); 
            //templateList = [SELECT id,Name,Case_Subject__c,Type__c,CreatedBy.Name,Status__c,Description__c,Case_Origin__c from CaseTemplate__c WHERE Type__c = :selectedFilter AND Case_Subject__c Like :searchQuery];
        }
        return null;
    }
    
    public PageReference search(){
        searchQuery = searchText + '%';
        if(String.isBlank(searchText) && selectedFilter == '--None--'){
            queryString = 'SELECT id,Name,Case_Subject__c,Type__c,CreatedBy.Name,Status__c,Description__c,Case_Origin__c from CaseTemplate__c';
            setCon = new ApexPages.StandardSetController(Database.getQueryLocator(queryString));
            setCon.setPageSize(size);
            noOfRecords = setCon.getResultSize();
            //templateList = [SELECT id,Name,Case_Subject__c,Type__c,CreatedBy.Name,Status__c,Description__c,Case_Origin__c from CaseTemplate__c];
        }else if(selectedFilter == '--None--'){
            queryString = 'SELECT id,Name,Case_Subject__c,Type__c,CreatedBy.Name,Status__c,Description__c,Case_Origin__c from CaseTemplate__c WHERE Case_Subject__c Like :searchQuery';
            setCon = new ApexPages.StandardSetController(Database.getQueryLocator(queryString));
            setCon.setPageSize(size);
            noOfRecords = setCon.getResultSize();
            //templateList = [SELECT id,Name,Case_Subject__c,Type__c,CreatedBy.Name,Status__c,Description__c,Case_Origin__c from CaseTemplate__c WHERE Case_Subject__c Like :searchQuery];
        }else{
            queryString = 'SELECT id,Name,Case_Subject__c,Type__c,CreatedBy.Name,Status__c,Description__c,Case_Origin__c from CaseTemplate__c WHERE Case_Subject__c Like :searchQuery AND Type__c = :selectedFilter';
            setCon = new ApexPages.StandardSetController(Database.getQueryLocator(queryString));
            setCon.setPageSize(size);
            noOfRecords = setCon.getResultSize();
            //templateList = [SELECT id,Name,Case_Subject__c,Type__c,CreatedBy.Name,Status__c,Description__c,Case_Origin__c from CaseTemplate__c WHERE Case_Subject__c Like :searchQuery AND Type__c = :selectedFilter];
        }
        return null;
    }
    
    public String sortExpression
    {
        get {
        return sortExp;
        } 
        set{
        if (value == sortExp)
        sortDirection = (sortDirection == 'ASC')? 'DESC' : 'ASC';
        else
        sortDirection = 'ASC';
        sortExp = value;
        }
    }
    
    public String getSortDirection(){
    if (sortExpression == null || sortExpression == '')
    return 'ASC';
    else
    return sortDirection;
    }
             
    public void setSortDirection(String value){  
    sortDirection = value;
    }
    
    public PageReference sortData(){
        string sortFullExp = sortExpression  + ' ' + sortDirection;
        queryString='SELECT id,Name,Case_Subject__c,Type__c,CreatedBy.Name,Status__c,Description__c,Case_Origin__c FROM CaseTemplate__c ORDER BY ' + sortFullExp ;
        setCon = new ApexPages.StandardSetController(Database.getQueryLocator(queryString));
        setCon.setPageSize(size);
        noOfRecords = setCon.getResultSize();
        return null;
    }
    
    public PageReference createTemplate(){
        return new PageReference('/apex/AddTemplate');
    }
    public PageReference cancel(){
        return new PageReference('https://ap2.salesforce.com/500/o');
    }
}
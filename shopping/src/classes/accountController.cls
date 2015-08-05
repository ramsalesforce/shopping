global class accountController {
    private ApexPages.StandardController controller;
    
    public accountController(ApexPages.StandardController controller) {
        this.controller = controller;
    }
    
    public List<SelectOption> getAccountOption(){
        List<SelectOption> options = new List<SelectOption>();
        options.add(new selectOption('', '- None -')); 
        for (Account accObj :[SELECT Id, Name FROM Account]){
            options.add(new selectOption(accObj.Id, accObj.Name)); 
        }
        return options;
    }
    
    
    
    public String searchTerm{get; set;}
    public String selectedAccount{get; set;}
    
    // JS Remoting action called when searching for a movie name
    @RemoteAction
    global static List<Account> searchAccount() {
        //System.debug('Account Name is: '+searchTerm );
        List<Account> acc = [Select Id, Name from Account];
        return acc;
    }
    
   // public List<

}
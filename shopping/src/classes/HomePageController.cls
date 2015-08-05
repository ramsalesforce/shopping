global with sharing class HomePageController{
    public String address{get;set;}
    public String modeOfPayment{get;set;}
    
    //holds values of selectecd brands
    String[] brands = new String[]{};
    //hold "Type__c" value which is selected by the end user 
    public String selectedType{get;set;}
    //hold all picklist values of "Type__c" field of Product Object
    public List<String> type{set;}
    //hold User name of an Account
    public String userName{get;set;}
    //Suggested outfit Products
    public List<Product2> products{get;set;}
    //Suggested RequestBox Products
    public List<Product2> productForRB{get;set;}
    // Home page Products
    public List<Product2> allProductsDemo{get;set;}
    // Product Object to Get Product Details Using pId
    public Product2 productDetails{get;set;}
    // Add To Cart Item 
    public Cart__c cartItem{get;set;}
    // Cart List Of a Particular User
    public List<Cart__c> cartList{get;set;}
    // RequestBox Object to Get RequestBox Details Using rId
    public Request_Box__c req{get;set;}
    // Outfit Object to Get Outfit Details Using oId
    public Outfit__c out{get;set;}
    //holds Account id value
    public Id accId{get;set;}
    //holds RequestBox id value
    public Id rId{get;set;}
    //holds Outfit id value
    public Id oId{get;set;}
    //holds Cart Item id value
    public Id cId{get;set;}
    //holds Product id value
    public Id pId{get;set;}
    //holds Order id value
    public Id mId{get;set;}
    //holds Unit Price Of Product
    public String uPrice{get;set;}
    //holds Product "Type__c" field value
    public String myorderType{get;set;}
    //Account Object to Get Account Details Using accId
    public Account account{get;set;}
    // Outfit Object to List out all Outfits for an Account
    public List<Outfit__c> outfit{get;set;}
    // RequestBox Object to List out all RequestBoxes for an Account
    public List<Request_Box__c> request{get;set;}
    //Add New RequestBox Object
    public Request_Box__c requestbox{get;set;}
    //Add New Outfit Object
    public Outfit__c outfitObj{get;set;}
    // Add to Cart Variables
    public Double unitPrice{get;set;}
    //Make Order
    public My_Order__c myOrder{get;set;}
    //My Order List
    public List<My_Order__c> myOrders{get;set;}
    
    // extra code
    public static Cart__c cartProduct;
    //public string Onload{get;set;}
    //constructor
    public HomePageController(){
        
        // retrieving Id of various record using parameters passed in Url.....
        accId = apexpages.currentPage().getParameters().get('aid');
        rId = apexpages.currentPage().getParameters().get('rid');
        oId = apexpages.currentPage().getParameters().get('oid');
        cId = apexpages.currentPage().getParameters().get('cid');
        pId = apexpages.currentPage().getParameters().get('pid');
        uPrice = apexpages.currentPage().getParameters().get('price');
        mId = apexpages.currentPage().getParameters().get('mId');
        myorderType = apexpages.currentPage().getParameters().get('type');
        //Onload = '<script>load('+accId+');</script>';
        //address = apexpages.currentPage().getParameters().get('address');
        //modeOfPayment = apexpages.currentPage().getParameters().get('modeOfPayment');
        if(accId != null){
            //generating Account details
            account = [SELECT Id,Name,Username__c,Password__c,Email__c,Phone FROM Account WHERE id = :accId];
            userName = account.Name;
            //generating Outfit details
            outfit = [SELECT Id,Account__c,Shirt_Size__c,Trouser_Length__c,Outfit_Type__c,Waist__c,Pant_Shape__c,Shirt_Shape__c FROM Outfit__c WHERE Account__c = :accId];
            //generating RequestBoxes Details
            request = [SELECT Id,Account__c,Outwear__c,Shirt_Type__c,Trouser_Type__c,Accessories__c,Purpose__c,Date__c,Notes_and_Comments__c FROM Request_Box__c WHERE Account__c = :accId];
        }
        if(rId != null){
            //generating details of a particular RequestBox using rId
            req = [SELECT Id,Account__c,Outwear__c,Shirt_Type__c,Trouser_Type__c,Accessories__c,Purpose__c,Date__c,Notes_and_Comments__c FROM Request_Box__c WHERE Id = :rId];
        }
        if(oId != null){
            //generating details of a particular Outfit using oId
            out = [SELECT Id,Account__c,Shirt_Size__c,Trouser_Length__c,Outfit_Type__c,Waist__c,Pant_Shape__c,Shirt_Shape__c FROM Outfit__c WHERE Id = :oId];
        }
        // initializing New Requestbox Object
        requestBox = new Request_Box__c();
        // initializing New Outfit Object
        outfitObj = new OutFit__c();
        
        if(cId != null){
            cartItem = [SELECT Id, Product__c, Account__c,Unit_Price__c,Type__c,Waist__c,Shirt_Size__c,Quantity__c,Color__c FROM Cart__c WHERE Id =: cId];
        }else{
            cartItem = new Cart__c();
            cartItem.Account__c = accId;
            cartItem.Product__c = pId;
            cartItem.Type__c = myOrderType;
            if(uPrice != null){
                cartItem.Unit_Price__c = double.valueOf(uPrice);
            }
        }
        
        //to get all cart Items which are already present in the cart of an account
        cartList = [SELECT Id, Product__c, Account__c,Unit_Price__c,Type__c,Waist__c,Shirt_Size__c,Quantity__c,Color__c FROM Cart__c WHERE Account__c = :accId];
        //Intializing MyOrder Object 
        
        if(accId != null && pId != null){
            myOrder = new My_Order__c();
            myOrder.Account__c = accId;
            myOrder.Product__c = pId;
            myOrder.Type__c = myOrderType;
            if(uPrice != null){
                myOrder.Price__c = double.valueOf(uPrice);
            }
        }else{
            myOrder = new My_Order__c();
            myOrder.Account__c = cartItem.Account__c;
            myOrder.Product__c = cartItem.Product__c;
            myOrder.Type__c = cartItem.Type__c;
            myOrder.Price__c = cartItem.Unit_Price__c; 
            myOrder.Waist__c = cartItem.Waist__c;
            myOrder.Size__c = cartItem.Shirt_Size__c;
            myOrder.Quantity__c = cartItem.Quantity__c; 
            myOrder.Color__c = cartItem.Color__c;
        }
        
        //to get all Orders of an Account
        myOrders = [SELECT Id,Account__c,Product__c,Color__c,Size__c,Type__c,Waist__c,Address__c,Mode_Of_Payment__c,Quantity__c,Price__c,Total__c,Date_Of_Order__c,Date_Of_Delivery__c,Status__c FROM My_Order__c WHERE Account__c =:accId];
        //List of all Product Images in the Home Page
        allProductsDemo = [Select Id,(SELECT Id FROM Attachments) From Product2 Where Outfit__c != null];
        
        if(pId != null){
            //used to display details of a product when it was selected from home page
            productDetails = [SELECT Id,Outfit__c,Name,ProductCode,Type__c,(SELECT UnitPrice FROM PricebookEntries),(SELECT Id From Attachments) FROM Product2 WHERE Id =: pId ];
        }
        brands = new String[]{'Reebok','Levis','Lee','Mufti','Locomotive','Jack n Jones'}; 
        addBrands();       
    }
    
    public void addBrands(){
        chectBoxOptions = new List<SelectOption>();
        for(String brand : brands){
            chectBoxOptions.add(new SelectOption(brand,brand));
        }
    }
    
    //Editing Account Details
    public PageReference edit() {
        return new PageReference('/apex/EditAccountDetails?aid='+accId).setRedirect(true);
    }
    
    //Code For EditAccountDetails "Save" Button
    public PageReference save() {
        upsert account;
        return new PageReference('/apex/welcome?aid='+accId).setRedirect(true);
    }
        
    //Code for EditRequestBox "Save" Button
    public PageReference saveRequestBox() {
        upsert req;
        return new PageReference('/apex/welcome?aid='+accId).setRedirect(true);
    }
    
    // adding Request Box    
    public PageReference addRequestBox() {
        return new PageReference('/apex/AddRequestBox?aid='+accId).setRedirect(true);
    }

    // Saving New Request Box
    public PageReference saveRequestBoxes(){
        requestBox.Account__c = accId;
        insert requestBox;
        return new PageReference('/apex/welcome?aid='+accId).setRedirect(true);
    }
    
    //Deleting a RequestBox
    public PageReference deleteRequestBox() {
        if(rId != null){
            requestBox = [SELECT Id,Account__c,Outwear__c,Shirt_Type__c,Trouser_Type__c,Accessories__c,Purpose__c,Date__c,Notes_and_Comments__c FROM Request_Box__c WHERE Id = :rId];
        }
        delete requestBox;
        return new PageReference('/apex/welcome?aid='+accId).setRedirect(true);
    }
    
    // Displaying Products related to Request Boxes
    public void displayProductForRequestBox() {
        System.debug('HomePageController-----------------------displayProducts()-'+rId);
        productForRB = [SELECT Id,ProductCode,Name FROM Product2 WHERE Request_Box__c = :rId];
    }
    
    //code for "Add Outfit" Button
    public PageReference addOutfit() {
        return new PageReference('/apex/AddOutfit?aid='+accId).setRedirect(true);
    }
    
    //Saving New Outfit
    public PageReference saveNewOutfit(){
        outfitObj.Account__c = accId;
        insert outfitObj;
        return new PageReference('/apex/welcome?aid='+accId).setRedirect(true);
    }
    
    //editing Outfit
    public PageReference editOutfit() {
        return new PageReference('/apex/EditOutfitDetails?aid='+accId).setRedirect(true);
    }
    
    //Deleting a Outfit
    public PageReference deleteOutfit() {
        if(oId != null){
            outfitObj = [SELECT Id,Account__c,Shirt_Size__c,Trouser_Length__c,Outfit_Type__c,Waist__c,Pant_Shape__c,Shirt_Shape__c FROM Outfit__c WHERE Id = :oId];
        }
        delete outfitObj;
        return new PageReference('/apex/welcome?aid='+accId).setRedirect(true);
    }
    
    // Displaying Products related to Outfits
    public void displayProducts() {
        System.debug('HomePageController-----------------------displayProducts()-'+oId);
        products = [SELECT Id,ProductCode,Name FROM Product2 WHERE Outfit__c = :oId];
    }
    
    //Code For EditOutfitDetails "Save" Button
    public PageReference saveOutfit() {
        upsert out;
        return new PageReference('/apex/welcome?aid='+accId).setRedirect(true);
    }
          
    //Adding Products to Cart 
    public PageReference addToCart(){
        //to get all cart Items which are already present in the cart of an account
        cartList = [SELECT Id, Product__c, Account__c,Unit_Price__c,Type__c FROM Cart__c WHERE Account__c = :accId];
        for(Cart__c c : cartList){
            if(c.Product__c == pId && c.Account__c == accId){
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.severity.WARNING,'Item Already in Cart');
                System.debug('addToCart--------------------------->Error Msg------------------------->'+myMsg); 
                ApexPages.addMessage(myMsg);
                return null;
            }
        }
        
        insert cartItem;
        ApexPages.Message myMsg = new ApexPages.Message(ApexPages.severity.CONFIRM,'Item Added Sucessfully to Cart');
        System.debug('addToCart--------------------------->Msg------------------------->'+myMsg); 
        ApexPages.addMessage(myMsg);
        return null;
        //return new PageReference('/apex/welcome?aid='+accId).setRedirect(true);
   }
   
   // extra addition
   @RemoteAction   
   global static void addProduct(Id productId,Id accountId){
       cartProduct = new Cart__c();
       cartProduct.Account__c = accountId;
       cartProduct.Product__c = productId;
       //cartProduct.Unit_Price__c = double.valueOf(uPrice);
       insert cartProduct;
   }
   
   @RemoteAction
   global static void removeProduct(Id productId,Id accountId){
       cartProduct = [SELECT Account__c,Product__c from Cart__c WHERE Product__c =: productId AND Account__c =: accountId];
       delete cartProduct;
   }
   
   @RemoteAction
   global static List<Cart__c> gatherProducts(Id accountId){
       List<Cart__c> cartProductsList = new List<Cart__c>();
       cartProductsList = [SELECT Product__c from Cart__c WHERE Account__c =: accountId];
       return cartProductsList;
   } 
       
    // Deleting Cart Item
    public PageReference deleteCartItem() {
        if(cId != null){
            cartItem = [SELECT Id, Product__c, Account__c FROM Cart__c WHERE Id =: cId];
            delete cartItem;
        }
        return new PageReference('/apex/welcome?aid='+accId).setRedirect(true);
    }
        
    // Sending Order
    public PageReference sendOrder(){
        //myOrder.Account__c = accId;
        //myOrder.Product__c = pId;
        insert myOrder;
        if(cId != null){
            deleteCartItem();
        }
        return new PageReference('/apex/welcome?aid='+accId).setRedirect(true);
    }

    // Code To buy All Products which are in Cart
    public PageReference buyAllProductsInCart(){
        System.debug('buyAllProductsInCart------------------------------------------------------modeOfPayment------------------->'+modeOfPayment+'--------address-------->'+address+'---accountId--------->'+accId);
        List<My_Order__c> myOrderList = new List<My_Order__c>();
        List<Cart__c> cartListToBeDeleted = new List<Cart__c>();
        cartList = [SELECT Id, Product__c, Account__c,Unit_Price__c,Type__c,Waist__c,Shirt_Size__c,Quantity__c,Color__c FROM Cart__c WHERE Account__c = :accId];
        for(Cart__c cart : cartList){
            myOrder = new My_Order__c();
            myOrder.Account__c = cart.Account__c;
            myOrder.Product__c = cart.Product__c;
            myOrder.Type__c = cart.Type__c;
            myOrder.Price__c = cart.Unit_Price__c; 
            myOrder.Waist__c = cart.Waist__c;
            myOrder.Size__c = cart.Shirt_Size__c;
            myOrder.Quantity__c = cart.Quantity__c; 
            myOrder.Color__c = cart.Color__c;
            myOrder.Address__c = address;
            myOrder.Mode_Of_Payment__c = modeOfPayment;
            myOrderList.add(myOrder);
            cartListToBeDeleted.add(cart);
        }
        insert myOrderList;
        delete cartListToBeDeleted;
        return new PageReference('/apex/welcome?aid='+accId).setRedirect(true);
    }
    
    //Code For "Cancel" Button
    public PageReference cancel() {
        return new PageReference('/apex/welcome?aid='+accId).setRedirect(true);
    }
    
    //getting Picklist values of Product Object "Type" field
    public List<SelectOption> getType(){
        List<SelectOption> options = new List<SelectOption>();
        Schema.DescribeFieldResult fieldResult = Product2.Type__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        options.add(new SelectOption('All','All'));
        for( Schema.PicklistEntry f : ple){
            options.add(new SelectOption(f.getLabel(), f.getValue()));
        }       
        return options;
    }
    
    public List<SelectOption> getPaymentOption(){
        List<SelectOption> options = new List<SelectOption>();
        Schema.DescribeFieldResult fieldResult = My_Order__c.Mode_Of_Payment__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry f : ple){
            options.add(new SelectOption(f.getLabel(), f.getValue()));
        }       
        return options;
    }
    
    // Displaying Selected Product When User Choose the PickList i.e "Type" value and brands in the home tab..
    public PageReference displaySelectedProducts(){
        if(selectedType == 'All'){
            brands = new String[]{'Reebok','Levis','Lee','Mufti','Locomotive','Jack n Jones'}; 
            allProductsDemo = [Select Id,(SELECT Id FROM Attachments) From Product2 Where Outfit__c != null AND Brand__c IN :brands];
            return new pagereference('<script>window.onload('+accId+');</script>');
        }else{
            brands.clear();
            System.debug('displaySelectedProducts()========================================brands--->'+brands);
            List<Product2> productFallInBrands = [select brand__c from Product2 where Type__c = :selectedType];
            Set<String> brandOptions = new Set<String>();
            for(Product2 pro : productFallInBrands){
                if(pro.brand__c != null){
                    brandOptions.add(pro.brand__c);
                }
            }
            for(String brand :brandOptions){
                brands.add(brand);
            }
            System.debug('displaySelectedProducts--------------------------------------------------------------------->'+brandOptions);
            allProductsDemo = [SELECT Id,(SELECT Id FROM Attachments) FROM Product2 WHERE Type__c = :selectedType AND Brand__c IN :brands];
        }
        addBrands();
        return null;
    }
    
    public PageReference displaySelectedBrandProducts(){
        
        System.debug('displaySelectedBrandProducts----------selectedType----------->'+selectedType+'---displaySelectedProducts----------brands----------->'+brands);
        if(selectedType == 'All' && brands.isEmpty()){
            allProductsDemo = null;
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.WARNING,'Please Select a Brand to continue shopping');
            System.debug('displaySelectedBrandProducts--------------------------->Error Msg------------------------->'+myMsg);
            ApexPages.addMessage(myMsg);
            
        }else if(selectedType == 'All' && !brands.isEmpty()){
            allProductsDemo = [SELECT Id,(SELECT Id FROM Attachments) FROM Product2 WHERE outfit__c != null AND Brand__c IN :brands];
            
        }else if(selectedType != 'All' && brands.isEmpty()){
            allProductsDemo = null;
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.WARNING,'Please Select a Brand to continue shopping');
            System.debug('displaySelectedBrandProducts--------------------------->Error Msg------------------------->'+myMsg);
            ApexPages.addMessage(myMsg);
            
        }else if(selectedType != 'All' && !brands.isEmpty()){
            allProductsDemo = [SELECT Id,(SELECT Id FROM Attachments) FROM Product2 WHERE Type__c = :selectedType AND Brand__c IN :brands];
            System.debug('displaySelectedBrandProducts========================================brands--->'+brands);
        }
        return null;
    }
    
    
    
    public String[] getBrands() {
        System.debug('getBrands========================================brands--->'+brands);
        return brands;
    }
    public void setBrands(String[] brands) {
        System.debug('setBrands========================================brands--->'+brands);
        this.brands = brands;
    }
    List<SelectOption> chectBoxOptions;
    //getting Picklist values of Product Object "Brand__c" field
    public List<SelectOption> getItems(){
        /*chectBoxOptions = new List<SelectOption>();
        Schema.DescribeFieldResult fieldResult = Product2.Brand__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        Set<String> brandSet = new Set<String>(brands);
        
        for( Schema.PicklistEntry f : ple){
            if(brandSet.contains(f.getLabel())){
                chectBoxOptions.add(new SelectOption(f.getLabel(), f.getValue()));
            }
        }*/
        return chectBoxOptions;
    }
      
    
    // Signing out from Account
    public PageReference signOut(){
        return new PageReference('/apex/shoppingpage').setRedirect(true);
    }
    
    // Cancelling Order and assign Status to "Cancelled"
    public PageReference cancelOrder(){
        //object used during cancellation of Order
        if(mId != null){
           myOrder =[SELECT Id,Account__c,Product__c,Color__c,Size__c,Address__c,Mode_Of_Payment__c,Quantity__c,Price__c,Total__c,Date_Of_Order__c,Date_Of_Delivery__c,Status__c FROM My_Order__c WHERE Id =: mId]; 
           myOrder.Status__c = 'Cancelled';
        }
        upsert myOrder;
        return new PageReference('/apex/welcome?aid='+accId).setRedirect(true);
    }

}
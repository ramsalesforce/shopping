public class ProductWrapper {
    public Product2 productObj{get;set;}
    public Boolean productState{get;set;}
    public ProductWrapper(Product2 productObj,Boolean productState){
        this.productObj = productObj;
        this.productState = productState;
    }
}
@isTest
public class ProductRelatedListDataFactory {
    public static Product2 createProduct(String Name,String ProductCode,String Family){
        Product2 productObj = new Product2(Name=Name,ProductCode=ProductCode,Family=Family);
        insert productObj;
        return productObj;
    }

}
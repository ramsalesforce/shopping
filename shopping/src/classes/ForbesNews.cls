public class ForbesNews {
    private static Http http;
    private static HttpRequest httpRequest;
    static{
        http=new Http();
        httpRequest=new HttpRequest();
    }
   
    public String selectedNewsType{get;set;}
    public List<News> newsList{get;set;}
    public List<SelectOption> newsType{get;set;}
   
    public ForbesNews(){
       
        this.newsType=new List<SelectOption>();
        selectedNewsType='http://www.forbes.com/markets/feed/';
        this.newsList=new List<News>();
        try{
            for(Dom.XmlNode node : this.getRSSFeed(selectedNewsType)){
                this.newsList.add(this.convertFeedToNews(node));
            }
        }catch(Exception ex){
            System.debug('Exception in ForbesNews '+ex.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'An error occured'));
        }
        this.newsType.add(new SelectOption('http://www.forbes.com/markets/feed/','Market'));
        this.newsType.add(new SelectOption('http://www.forbes.com/business/feed/','Business'));
        this.newsType.add(new SelectOption('http://www.forbes.com/autos/feed/','Auto Mobile'));
        this.newsType.add(new SelectOption('http://www.forbes.com/finance/feed/','Finanace'));
        this.newsType.add(new SelectOption('http://www.forbes.com/entrepreneurs/feed/','Entrepreneurs'));
        this.newsType.add(new SelectOption('http://www.forbes.com/technology/feed/','Technology'));
        this.newsType.add(new SelectOption('http://www.forbes.com/intelligent-technology/feed/','Intelligence Technology'));
        this.newsType.add(new SelectOption('http://www.forbes.com/security/feed/','Security'));
        this.newsType.add(new SelectOption('http://www.forbes.com/bonds/feed/','Bonds'));
        this.newsType.add(new SelectOption('http://www.forbes.com/options/feed/','Option'));
    }
   
    public void displayNews(){
        this.newsList=new List<News>();
        try{
            for(Dom.XmlNode node : this.getRSSFeed(selectedNewsType)){
                this.newsList.add(this.convertFeedToNews(node));
           }
        }catch(Exception ex){
            System.debug('Exception in ForbesNews.displayNews  '+ex.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'An error occured'));
        }
       
    }
   
    private List<Dom.XMLNode> getRSSFeed(String URL) {
        try{
            httpRequest.setEndpoint(url);
            httpRequest.setMethod('GET');
            HttpResponse response = http.send(httpRequest);
            Dom.Document doc = response.getBodyDocument();
            Dom.XMLNode rss = doc.getRootElement();
           
            System.debug('ForbesNews getRSSFeed Root Element' + rss.getName());
           
            List<Dom.XMLNode> rssList = new List<Dom.XMLNode>();
            for(Dom.XMLNode child : rss.getChildren()) {
                System.debug('ForbesNews getRSSFeed Child Element' + child.getName());
                for(Dom.XMLNode channel : child.getChildren()) {
                    try{
                        System.debug('ForbesNews getRSSFeed Children Element' + channel.getName());
                        if(channel.getName() == 'item') {
                            rssList.add(channel);
                        }
                    }
                    catch(Exception ex){
                        System.debug('Exception in ForbesNews.getRSSFeed traversing news  '+ex.getMessage());
                    }
                }
            }
            return rssList;
        }
        catch(Exception ex){
            System.debug('Exception in ForbesNews.getRSSFeed =========>  '+ex.getMessage());
            return null;
        }
    }
    private News convertFeedToNews(Dom.XMLNode feed) {
        try{
            News news= new News();
            String fullDescription='';
            for(Dom.XMLNode child : feed.getChildren()) {
                System.debug('ForbesNews convertFeedToNews child :: ' + child.getName());
                if(child.getName() == 'title') { news.title = child.getText(); }
                if(child.getName() == 'pubDate') { news.publishedOn = child.getText(); }
                if(child.getName() == 'guid') { news.link = child.getText(); }
                if(child.getName() == 'description') { fullDescription=child.getText();news.description =fullDescription; }
            }
            System.debug('ForbesNews.convertFeedToNews   news   '+news);
            return news;
        }catch(Exception ex){
            System.debug('Exception in ForbesNews.convertFeedToNews  '+ex.getMessage());
            return null;
        }
    }
}
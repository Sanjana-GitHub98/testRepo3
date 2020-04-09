public class AnimalLocator {

    public static String getAnimalNameById(Integer Id)
    {
        HTTP htp=new HTTP();
        HttpRequest req=new HttpRequest();
        req.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/'+Id);
        req.setMethod('GET');
        HttpResponse resp=htp.send(req);
        String respStr=resp.getBody();
        return respStr;
    }
}
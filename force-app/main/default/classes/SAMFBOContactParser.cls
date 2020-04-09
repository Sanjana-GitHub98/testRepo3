/* 
* Developer: Sanjana Sahu
* Created Date: 04-11-2019
* Description: This class is used for Beta.SAM.Gov to handle Contact Pattern.
* Last Modified By/Date: Sanjana Sahu/06-11-2019
*/
public class SAMFBOContactParser {
    private static String contactName = '';
    private static String contactEmailId = '';
    private static String contactPhone = '';
    private static String contactTitle = '';
    
  public static Contact extractContactInfo1(String contactInfo){
        try{
            Contact con = null;
            if( contactInfo != null ){
                //System.debug('contactInfo.length()->>'+contactInfo.length());
                if(contactInfo.length()< 200 ){
                   if(contactInfo.contains(','))
                    {
                        String[] contactCommaSplited=contactInfo.split(',');
                        if(contactCommaSplited != null){
                            if(contactCommaSplited.size() > 0){
                                System.debug('3333');
                                String contactCommaSplitInfo=contactCommaSplited[1];
                                System.debug('contactCommaSplitInfo=='+contactCommaSplitInfo);
                                 if(contactInfo.contains('Name:') && contactInfo.contains('Title:') && contactInfo.contains('Phone:') && contactInfo.contains('Fax:') && contactInfo.contains('Email:') ){
                                       con = getContactPatern4(contactInfo);
                                   }
                                else if(Pattern.compile('^([0-9]+-)*[0-9]+$').matcher(contactCommaSplitInfo).matches())
                                {
                                    con = getContactPattern5(contactInfo);  
                                }
                                System.debug('con -->method2='+con);
                                return con;
                            }
                        }
                        
                    }
                      else if(contactInfo.contains(' ')){
                        String[] contactSplitData=contactInfo.split(' ');
                        if(contactSplitData != null){
                            if(contactSplitData.size() > 2){
                                String contactInfo1=contactSplitData[2];
                                if(contactInfo.contains('Name:') && contactInfo.contains('Title:') && contactInfo.contains('Phone:') && contactInfo.contains('Fax: ') && contactInfo.contains('Email:') ){
                                       con = getContactPatern4(contactInfo);
                                   }
                                else if(contactInfo1.equals('-'))
                                {
                                    con = getContactPattern1(contactInfo);
                                    
                                }
                                else if(!contactInfo1.isNumeric()){
                                    con = getContactPattern2(contactInfo);
                                }
                                else if(contactInfo1.isNumeric() || contactSplitData[3].isNumeric()){
                                    con = getContactPattern3(contactInfo);
                                }
                                System.debug('con -->method1='+con);
                                return con;
                            } 
                        }
                    }
                }
            }
            return null;
        }catch(Exception ex){
            System.debug('Execption SAMFBPContactParser'+ex.getMessage()+' : '+ex.getLineNumber());
            return null;
        }
    }
    
    private static Contact getContactPattern1(String contactInfo){
        Contact con=new Contact();
        //Example --- contactInfo= 'Isaac Hernandez - Contract Specialist\nIsaac.Hernandez-Cosme@va.gov\n\n<a href=\"mailto:Isaac.Hernandez-Cosme@va.gov\">Isaac Hernandez - Contract Specialist</a> primary Isaac.Hernandez-Cosme@va.gov owner';
        try{
            String[] splitedContactList=contactInfo.split('\n');
            contactName=contactInfo.substringBefore('-');
            contactTitle=contactInfo.substringBetween('-', '\n');
            contactEmailId=contactInfo.substringBetween('mailto:', '">');
            String contactinfo2=splitedContactList[2];
            Boolean flag = Pattern.compile('^([0-9]+-)*[0-9]+$').matcher(contactinfo2).matches();
            if(flag)
            { contactPhone=contactinfo2;
             con.Phone=contactPhone;
            }
            String[] contactNameSplit=contactName.split(' ');
            if(contactNameSplit != null){
                con.FirstName=contactNameSplit[0];
                con.LastName=contactNameSplit[1];
                con.Email=contactEmailId;
                System.debug('Splited data Pattern1=>contactFullName->'+contactName+'=contactTitle='+contactTitle+'=contactEmail='+contactEmailId);
                return con;
            }
            return null;
        }catch(Exception ex){
            System.debug('Exception SAMFBPContactParser->Pattern1'+ex.getMessage()+' : '+ex.getLineNumber());
            return null;
        }
    }
    private static Contact getContactPattern2(String contactInfo){
        Contact con=new Contact();
        //Example --- contactInfo= 'Douglas Kustra\n\n<a href=\"mailto:douglas.kustra@va.gov\">douglas.kustra@va.gov</a> primary douglas.kustra@va.gov owner';
        try{  String[] splitedContactList=contactInfo.split('\n');
            contactName=splitedContactList[0];
            contactTitle=splitedContactList[1];
            String contactinfo2=splitedContactList[2];
            contactEmailId=contactInfo.substringBetween('mailto:', '">');
            System.debug('Splited Pattern2 contactFullName->'+contactName+'=contactTitle='+contactTitle+'=contactEmail='+contactEmailId);
            Boolean flag = Pattern.compile('^([0-9]+-)*[0-9]+$').matcher(contactinfo2).matches();
            if(flag)
            {
                contactPhone=contactinfo2;
                con.Phone =contactPhone;
            }
            String[] contactNameSplit=contactName.split(' ');
            con.FirstName=contactNameSplit[0];
            con.LastName=contactNameSplit[1];
            con.Email=contactEmailId;
            return con;
           }
        catch(Exception ex){
            System.debug('Exception SAMFBPContactParser->Pattern2'+ex.getMessage()+' : '+ex.getLineNumber());
            return null;
        }
    }
    private static Contact getContactPattern3(String contactInfo){ // condition fails if Title is give
        Contact con=new Contact();
        try{
            String phnValue='',nameValue='';
            //Example --- contactInfo='Susan Harris 65 67502648\n\n<a href=\"mailto:susan.harris@fe.navy.mil\">susan.harris@fe.navy.mil</a> primary susan.harris@fe.navy.mil owner';
            String[] conSplit1=contactInfo.split('\n');
            String contactRemoveEmail=contactInfo.remove(conSplit1 [2]).trim();
            contactEmailId=contactInfo.substringBetween('mailto:', '">');
            String[] contactSplitData=contactRemoveEmail.split(' ');
            for(String conList:contactSplitData){
                Boolean flag = Pattern.compile('^([0-9]+-)*[0-9]+$').matcher(conList).matches();
                if(flag){
                    phnValue=phnValue+conList;
                }
            }
            con.Phone=phnValue;
            con.FirstName=contactSplitData[0];
            con.LastName=contactSplitData[1];
            con.Email=contactEmailId;
            return con;
        }
        catch(Exception ex){
            System.debug('Execption SAMFBPContactParser->Pattern3'+ex.getMessage()+' : '+ex.getLineNumber());
            return null;
        } 
        
    }
    private static Contact getContactPatern4(String contactInfo){
        //Example --- Name: Client Services, Title: Client Services, Phone: 1.877.933.3243, Fax: 703.422.7822, Email: Clientservices@fedbid.com;        
        Contact con=new Contact();
        try{ 
            if(contactInfo!=null){
                
                String contactName1 = contactInfo.substringBetween('Name:','Title:');
                contactName = removeEndsWithSpecificSymbol(contactName1,',');
                String contactTitle1 = contactInfo.substringBetween('Title:','Phone:');
                contactTitle = removeEndsWithSpecificSymbol(contactTitle1,',');
                String contactEmailId1 = contactInfo.substringAfter('Email:');
                contactEmailId = removeEndsWithSpecificSymbol(contactEmailId1,';');
                String contactPhone1 = contactInfo.substringBetween('Phone:','Fax:');
                contactPhone = removeEndsWithSpecificSymbol(contactPhone1,',');
                String[] contactNameSplit=contactName.split(' ');
                // System.debug('contactName->'+contactName+'==contactNameSplit='+contactNameSplit+'=contactNameSplit[0]='+contactNameSplit[0]+'=contactNameSplit[1]='+contactNameSplit[1]);
                con.FirstName=contactNameSplit[0];
                con.LastName=contactNameSplit[1];
                con.Email=contactEmailId;
                con.Phone=contactPhone;
            }
        }catch(Exception ex){
            System.debug('Exception getContactPatern4 = '+ex.getMessage() +' : '+ex.getLineNumber());
            return null;
        }
        System.debug('Pattern4->'+con);        
        return con;
    }
    
    private static Contact getContactPattern5(String contactInfo)
    {
         Contact con=new Contact();
        try{
            System.debug('pattern5=');
            String[] contactCommaSplited=contactInfo.split(',');
            String contactCommaSplitInfo=contactCommaSplited[1];
            Boolean flag = Pattern.compile('^([0-9]+-)*[0-9]+$').matcher(contactCommaSplitInfo).matches();
            if(flag){
                con.Phone=removeEndsWithSpecificSymbol(contactCommaSplitInfo,',');
            }
            String contactPhnRemove=contactInfo.remove(contactCommaSplitInfo);
            if(contactPhnRemove.contains(' ')){
                String[] contactSplitData=contactPhnRemove.split(' ');
                con.FirstName=removeEndsWithSpecificSymbol(contactSplitData[0],',');
                con.LastName=removeEndsWithSpecificSymbol(contactSplitData[1],',');    
            }
            System.debug('con==>'+con);
            return con;
        }
        catch(Exception ex){
            System.debug('Execption SAMFBPContactParser->Pattern5'+ex.getMessage()+' : '+ex.getLineNumber());
            return null;
        } 
    }
    
    
    private static String removeEndsWithSpecificSymbol(String value,String symbol){
        if(value != null){
            value = value.trim();
            if(value.endsWith(symbol)){
                return value.removeEnd(symbol).trim();
            }            
        } 
        return value.trim();
    }
    
}
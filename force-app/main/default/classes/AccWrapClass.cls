public class AccWrapClass 
{
    public List<AccountWrapper> wrapList{get;set;}
    public List<ContactWrapper> contactWrapList{get;set;}
    public Set<Id>accountIdSet;
    public Set<Id>contactIdSet=new Set<Id>();
     list <Contact> selCont=new list<Contact>();  //to store contact id 
     

 
    public AccWrapClass()
    {
       
  
        wrapList = new List<AccountWrapper>();
        contactWrapList = new List<ContactWrapper>();
        accountIdSet = new Set<Id>();
        for(Account acc : [SELECT id, Name, AccountNumber, Account.Owner.Name FROM Account LIMIT 10]){
            wrapList.add(new AccountWrapper(acc));
        
         } 
    }
    //Account Wrapper Class
    public class AccountWrapper
    {
        public Boolean isCheck{get;set;}
        public Account acc{get;set;}
        
        public AccountWrapper(Account acc)
        {
            this.acc = acc;
            this.isCheck = false;
        }
    }
    //Contact Wrapper Class
    public class ContactWrapper
    {
        public Boolean isCheck{get;set;}
        public Contact con{get;set;}
        
        public ContactWrapper(Contact con)
        {
            this.con = con;
            this.isCheck = false;
        }
    }
    
   //Veiw Contact Method on Button Click 
    public void viewContact()
    {
       
        
        for(AccountWrapper accWrap:wrapList)
        {
            if(accWrap.isCheck)
            {
                accountIdSet.add(accWrap.acc.id);
            }
        }
         
            contactWrapList= new List<ContactWrapper>();
            
            for(Contact con:[select Id,Account.Id, Account.Name,Name,Phone,Email from Contact where Account.Id IN :accountIdSet])
            {  
                contactWrapList.add(new ContactWrapper(con));   
            }
        

        
        
    }
    //SEND EMAIL
    public void SendEmail()
    {
        System.debug('contactWrapList----'+contactWrapList);
        if(contactWrapList.size()>0){
      
        for(ContactWrapper wrapContactObj : contactWrapList) {
            if(wrapContactObj.isCheck) {
                contactIdSet.add(wrapContactObj.con.Id);
                
            }
        }
            System.debug('selCont'+contactIdSet); 
            if(contactIdSet.size()>0){
        List<Contact> conlist=[Select id ,lastName from contact where id IN :contactIdSet ];
            System.debug('conlist--'+conlist);
        List<Id> ids= new List<Id>();
        for(Contact c:conlist)
        {
            ids.add(c.id);
            System.debug('ids--'+ids);
        }
        EmailTemplate tem=[Select id,name from EmailTemplate where name = 'emailsend' limit 10];
        Messaging.MassEmailMessage Email = new Messaging.MassEmailMessage();
        Email.setTargetObjectIds(ids);
        Email.setSenderDisplayName('TEST EMAIL VIVA VF PAGE');
        Email.setTemplateId(tem.id);
        Messaging.sendEmail(new Messaging.MassEmailMessage[]{ Email });
        system.debug(Email);
         ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'EMAIL SEND...'));       
        }
            else{
                
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Select atleast One Contact to Send Email'));
            }
    
        } 
   }
}
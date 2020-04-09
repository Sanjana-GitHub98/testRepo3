public class OpportunityRollUp {    
    public static void OppTotAmt()
    { 
        Decimal Amt,TotAmt,GTotAmt;
        List <Opportunity> oppor = [Select Account.Id, Account.Name,Account.ParentId,Account.TotalAmount__c,
                                    Id, AccountId,Amount From Opportunity Where Account.ParentId !=null];
        List<Id> accCh=new List<Id>();
         Set<Id> accPare=new Set<Id>();
        for(Opportunity op: oppor){
            accCh.add(op.Account.Id);
            accPare.add(op.Account.ParentId);
        }
        List <String> oppHoldParentId =new List<String>();
        List <Opportunity> oppor1=new List <Opportunity>();
        Map<Account,List<Opportunity>> accToOppAmt= new map <Account,List<Opportunity>>();
        Map<Account,List<Account>> accToPacc= new Map<Account,List<Account>>();
        List <Account> acc=new List<Account>();
        List <Account> Paracc=new List<Account>();
        string PIdHold;
       /* for(Opportunity holdId:oppor )
        {
            oppHoldParentId.add(holdId.Account.ParentId);
        }*/
        // Totaling On Opportunity all Records
        for(Account acct: [SELECT Account.ParentId,Name, TotalAmount__c,
                           (SELECT ID, Amount FROM Opportunities) from Account WHERE Account.ParentId IN : oppHoldParentId])
        {
            accToOppAmt.put (acct, acct.Opportunities);      
            TotAmt=0;       
            for(Opportunity opp : accToOppAmt.get(acct))
            {    
                TotAmt= TotAmt + opp.Amount; 
            }        	
            acct.TotalAmount__c = TotAmt; 
            acc.add(acct);                  
        } 
        System.debug('amount total on Oppor-->>'+acc);
        update acc;
        
        List<Account> accChAmt=[SELECT Id, Account.ParentId, Name, TotalAmount__c from Account WHERE Account.ParentId IN : accPare];
            
            List<Account> accPAmt=[SELECT Id, Name, TotalAmount__c from Account WHERE Id IN : accPare]; //Storing Rollup amount on Parent
           
            for(Account p: accPAmt){
                 System.debug('parent Id: ' +p.Id);
                TotAmt=0;
                for(Account c: accChAmt){
                    IF(p.id==c.ParentId){
                    System.debug('Chi Id: ' +c.Id);
                    TotAmt=TotAmt+c.TotalAmount__c;
                    }
                }
                p.TotalAmount__c=TotAmt;
                System.debug('updATED AMT: '+TotAmt);
                Paracc.add(p);
            }
            System.debug('parent data: ' +Paracc);
            update Paracc;
        System.debug('Parent Account Total amt '+ acc);   
         Update acc; 
    }
}
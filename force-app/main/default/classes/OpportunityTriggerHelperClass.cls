public class OpportunityTriggerHelperClass {
    List<Account> accAmt=new List<Account>(); //For All Child Account Amount Total
    List<Account> accGAmt=new List<Account>(); //For GrandParent Amount Total
    List<Id> accParentId=new List<Id>();
    List<ID> parentIDLst = new List<ID>();
    List<Id> accId=new List<Id>();
    
    public void getOppurtunityAccId(List <Opportunity> oppTriggLst)
    {
        if(oppTriggLst!=null){
            for(Opportunity op:oppTriggLst){
                accId.add(op.AccountId); //getting Accountid from trigger
            }
        }
        List<Account> parentIDList = [SELECT ParentId FROM Account WHERE Id IN :accId];
        if(parentIDList!=null)
        {
            for(Account acc : parentIDList){
                parentIDLst.add(acc.ParentId);      //getting ParentId for AccountId-->Opportunity
            }
        }
    }
    //--------------------------- To perform  Insert operation.
    public void insertUpdOpp(List <Opportunity> oppTriggLst)
    {
        try{
            getOppurtunityAccId(oppTriggLst);
            AggregateResult[] aggResult=[SELECT AccountId acc,SUM(Amount)amt From Opportunity Where AccountId IN :accId GROUP BY AccountId];
            if(aggResult.size()>0)
            {
                for(AggregateResult accChList:aggResult)
                {
                    Account accUpdAmt=new Account(id=(ID)accChList.get('acc'),TotalAmount__c=(decimal)accChList.get('amt'));
                    accAmt.add(accUpdAmt);
                }
                try{
                    update accAmt;
                }
                catch(Exception e)
                {System.debug('Error while Account Child total after Update--->'+e);}
            }
            
            
            //---------------------------To Update Grand Parent Total On Account
            
            AggregateResult[] aggResultGrandTot=[SELECT ParentId pId,SUM(TotalAmount__c)GAmt FROM Account 
                                                 WHERE ParentId IN :parentIDLst GROUP BY ParentId];       
            
            if(aggResultGrandTot.size()>0)
            {
                for(AggregateResult accLst : aggResultGrandTot)
                {
                    Account accGrandTot = new Account(Id=(ID)accLst.get('pId'),TotalAmount__c=(Decimal)accLst.get('GAmt'));
                    accGAmt.add(accGrandTot);
                }
                try{
                    update accGAmt;
                }
                catch(Exception e)
                {System.debug('Error Inside Insert/Update Method-->'+e);}
            }
            
        }
        catch(Exception e)
        {System.debug('Error while entering in Insert/Update Method-->'+e);}
    }
    //------------------------Delete Opportunity
    public void deleteOpp(List <Opportunity> oppTriggLst)
    {
        try{
            getOppurtunityAccId(oppTriggLst);
            
            AggregateResult[] aggResult=[SELECT AccountId acc,SUM(Amount)amt From Opportunity Where AccountId IN :accId GROUP BY AccountId];
            for(AggregateResult accChList:aggResult)
            {
                Account accUpdAmt=new Account(id=(ID)accChList.get('acc'),TotalAmount__c=(decimal)accChList.get('amt'));
                accAmt.add(accUpdAmt);
            }
            try{
                update accAmt;
            }
            catch(Exception e)
            {System.debug('Error while Account Child total after delete'+e);}
            
            AggregateResult[] aggResultGrandTot=[SELECT ParentId pId,SUM(TotalAmount__c)GAmt FROM Account 
                                                 WHERE ParentId IN :parentIDLst GROUP BY ParentId];       
            for(AggregateResult accParentLst : aggResultGrandTot)
            {
                Account accGrandTot = new Account(Id=(ID)accParentLst.get('pId'),TotalAmount__c=(Decimal)accParentLst.get('GAmt'));
                accGAmt.add(accGrandTot);
            }
            try{
                update accGAmt;
            }
            catch(Exception e)
            {System.debug('Error while Account Parent Grandtotal after delete'+e);}
        }
        catch(Exception e)
        {System.debug('Error while entering in Delete Method-->'+e);}
    }
    
    
}
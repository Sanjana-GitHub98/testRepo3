public class UpdateOpp {
    public void getOpp()
    {
     List<Opportunity> opp=[select Id,Name,CloseDate from Opportunity where CloseDate=Today];
       for(Opportunity opL:opp)
        {
            opL.CloseDate=opL.CloseDate.addDays(30);
            System.debug('oppor-->'+opL+'GET DATA');
            
        }
      System.debug('Updated oppor-->'+opp);
      update opp;
    }

}
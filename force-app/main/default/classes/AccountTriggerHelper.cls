public class AccountTriggerHelper {
    public static void updateAccount(List<Account> accList)
    {
        List<Account> accLhold=[Select Id,Website from Account Where Name='Technomile'];
        for(Account acc:accList)
        {
         if(acc.ParentId==accLhold[0].Id)
         {
             acc.Website = accLhold[0].Website;
         }
        }
    }

}
global class UpdateOpporBatch implements Database.Batchable<sObject>{
    global Database.QueryLocator Start(Database.BatchableContext BC)
    {
      return Database.getQueryLocator('Select Id,LeadSource from Opportunity Where Id=\'0066F00000vwy73QAA\' LIMIT 5');    
    }
    global void execute(Database.BatchableContext BC, List<sObject> oppLead)
    {
        for(Sobject Obj:oppLead)
        {
            Obj.put('LeadSource','Web');
        }
        update oppLead;
    }
    global void Finish(Database.BatchableContext BC)
    {
        
    }
        

}
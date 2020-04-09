trigger OpportunityTrigger on Opportunity (after insert,after update,after delete) {
 if(trigger.IsAfter && (trigger.IsInsert || trigger.IsUpdate))
 {
     OpportunityTriggerHelperClass inUp=new OpportunityTriggerHelperClass();
         inUp.insertUpdOpp(trigger.new);
 }
    if(trigger.IsDelete)
    {
     OpportunityTriggerHelperClass del=new OpportunityTriggerHelperClass();
         del.deleteOpp(trigger.old);   
    }
}
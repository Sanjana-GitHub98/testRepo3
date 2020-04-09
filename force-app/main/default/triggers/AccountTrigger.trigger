trigger AccountTrigger on Account (before insert) {
    if(trigger.IsBefore && trigger.IsInsert){
        AccountTriggerHelper.updateAccount(trigger.new);
    }

}
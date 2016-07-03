global class BulkTouchRecords implements Database.Batchable<sObject> {

  global final String query;

  global BulkTouchRecords(String query){
    this.query = query;
  }
    
  global Database.QueryLocator start(Database.BatchableContext BC){
    return Database.getQueryLocator(query);
  }

  global void execute(Database.BatchableContext BC, List<sObject> scope){
    update scope;
  }

  global void finish(Database.BatchableContext BC){
  }

}
public without sharing class AccountUtility {
  @AuraEnabled
  public static Account createAccount(String name){
      try {
        // initialize the account
          Account ac = new Account();
          ac.Name = name;
          insert ac;
          ac.Name = name + '1243';
          //update ac ;
          Account ac1 =  [Select Id,Name from account limit 1];
          ac1.Name =name;
          update ac1; 
          return ac1;


          
      } catch (Exception e) {
          throw new AuraHandledException(e.getMessage());
      }
  }
}
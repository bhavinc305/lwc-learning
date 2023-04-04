public without sharing class BecomeADealerController {

    @AuraEnabled(cacheable=true)
    public static Account getAccountRecord(String Id){
        Account accountRecord = new Account();
        try{
            accountRecord = [SELECT Id, name, NumberOfEmployees, NumberofLocations__c, DunsNumber, ShippingCity, ShippingCountry, ShippingPostalCode, ShippingState
                             FROM Account 
                             WHERE Id =: Id 
                             LIMIT 1];
        }catch(Exception ex){
            throw new AuraHandledException('Something went wrong. Error Message: '+ex.getMessage());
        }
        return accountRecord;
    }


    @AuraEnabled
    public static string saveAccountRecord(Account updatedAccountRecord){
        try {
            update updatedAccountRecord;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        return 'ACCOUNT_UPDATE_SUCCESS';
    }

}
@isTest
public with sharing class TestDataUtility {
    public static List<Account> createAccounts(Integer noOfAccounts,String name){
        List<Account> accountList = new List<Account>();

        for(Integer i = 0; i < noOfAccounts; i++){
            accountList.add(new Account(Name = name));
        } 

        try{
            if(accountList.size() > 0){
                insert accountList;
            }
        }catch(DmlException dmlE){
            System.debug('Error occur at line : '+ dmlE.getLineNumber() + ' with the message : '+ dmlE.getMessage());
        }
        return accountList;
    }

    public static void  createCases(Integer noOfCases , List<Account> accountList, String caseStatus, String caseOrigin){
        List<case> caseList = new List<case>();

        for(Integer i = 0; i < noOfCases ; i++ ){
            caseList.add(new Case(
                Status = caseStatus,
                Origin = caseOrigin,
                AccountId = accountList[0].Id
            ));
        }
        try{
            if(caseList.size() > 0){
                Database.insert(caseList,false);
            }
        }catch(DmlException dmlE){
            System.debug('Error occur at line : '+ dmlE.getLineNumber() + ' with the message : '+ dmlE.getMessage());
        }
    }
}
@isTest
public with sharing class ViewHierarchyControllerTest {
    @TestSetup
    static void createData(){
        List<account> accountList = TestDataUtility.createAccounts(1, 'Test Account');
        TestDataUtility.createCases(5, accountList, 'New', 'Email');
    }

    @isTest
    static void testGetParentData(){
        Case cseRec = [select Id from Case limit 1];
        List<case> resultCaseList = ViewHierarchyController.getAllParentCases(cseRec.Id);

        System.assert(resultCaseList.size() == 1);
    }

    @isTest
    static void testGetChildCases(){
        List<Case> casList = [SELECT Id,CaseNumber,Status,Origin FROM Case];
        if(casList.size() > 0){
            Case childCase = casList[casList.size()-1];
            childCase.ParentId = casList[0].Id;
            update childCase;
        }
       List<case> childCaseList = ViewHierarchyController.getChildCases(casList[0].Id); 
       System.assert(childCaseList.size() == 1);
    }
}
/**
 * Added By : Bhavin Chauhan
 * @desc : Below class is the controller for viewHierachy component. 
 *          It will return current and parent case.
 */
public with sharing class ViewHierarchyController {
    /**
     * @desc : Below method will return the parent case record based on record Id
     * @param {string} parentId : record Id of the current page case record
     */
    @AuraEnabled(cacheable = true)
    public static List<Case> getAllParentCases(Id parentId){
        try {
            List<case> parentCasesList = new List<case>();
            //Checking the access fpor current logged in user
            if(
                Case.SObjectType.getDescribe().isAccessible() &&
                Schema.SObjectType.Case.fields.Id.isAccessible() &&
                Schema.SObjectType.Case.fields.CaseNumber.isAccessible() &&
                Schema.SObjectType.Case.fields.Origin.isAccessible() &&
                Schema.SObjectType.Case.fields.Subject.isAccessible() &&
                parentId != null
               
            ){
                parentCasesList = [SELECT Id, CaseNumber, Subject, Origin FROM Case WHERE Id =: parentId WITH SECURITY_ENFORCED  ];
            }
           return parentCasesList; 
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    
    /**
     * @desc : Below method will return the all child cases  based on recordId passed in
     * @param {string} parentId : record Id of the current page case record
     */
    @AuraEnabled(cacheable = true)
    public static List<Case> getChildCases(Id parentId) {
        try {
            List<case> childeCasesList = new List<case>();
             //Checking the access fpor current logged in user
            if(
                Case.SObjectType.getDescribe().isAccessible() &&
                Schema.SObjectType.Case.fields.Id.isAccessible() &&
                Schema.SObjectType.Case.fields.CaseNumber.isAccessible() &&
                Schema.SObjectType.Case.fields.Origin.isAccessible() &&
                Schema.SObjectType.Case.fields.Subject.isAccessible() &&
                parentId != null
            ){
                childeCasesList =  [
                    SELECT Id, CaseNumber, Subject, Origin FROM Case
                    WHERE ParentId = :parentId
                    WITH SECURITY_ENFORCED
                ];
            }
            return childeCasesList;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        
    }
}
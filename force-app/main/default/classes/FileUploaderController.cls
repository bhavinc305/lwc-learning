public without sharing class FileUploaderController {
   @AuraEnabled
   public static List<ContentVersion> updateContentVersion(List<Id> cvIDs, string type){
       try {
           List<ContentVersion> contentVersionList = new List<ContentVersion>([Select Id, File_Type__c from ContentVersion where Id  in :cvIDs  ]);
           System.debug('contentVersionList :'+ contentVersionList);
           for (ContentVersion cv : contentVersionList) {
               cv.File_Type__c = type; 
           }
           update contentVersionList;
           return contentVersionList;
        } catch (Exception e) {
           throw new AuraHandledException(e.getMessage());
       }
   }
}
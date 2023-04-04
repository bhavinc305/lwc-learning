public without sharing class fileDeleterController {
   
    @AuraEnabled
    public static List<ContentVersion> getFileContents(Id parentRecordId){
        try {
            // Retrive all the content document list
           List<ContentDocumentLink> contentDocumentList = [
                                                            SELECT ContentDocumentID, LinkedEntityId 
                                                            from ContentDocumentLink WHERE LinkedEntityId = : parentRecordId
                                                        ];
            System.debug('contentDocumentList :'+contentDocumentList);
            //Create a set to store the contentdocumentId
            Set<ID> contentDocumentIdSet = new Set<Id>();

            for(ContentDocumentLink cdl : contentDocumentList){
                contentDocumentIdSet.add(cdl.ContentDocumentId);
            }

            //Retriving ContentVersionList fron contentDocumentIdSet
            List<ContentVersion> contentVersionList = [
                                                        SELECT ID,VersionData,FileType,Title,
                                                        FileExtension,ContentDocument.CreatedBy.Name,
                                                        ContentDocument.FileType
                                                        FROM ContentVersion
                                                        WHERE ContentDocumentId in : contentDocumentIdSet
                                                    ];
            
            return contentVersionList;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static void deleteContentDocument(String recordId) {
        Database.delete(recordId);
    }
}
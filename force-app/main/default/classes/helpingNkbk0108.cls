public class helpingNkbk0108 {
    
    private static final Set<String> PROFILES_RESTRICT_TO_DRAFT = new Set<String>{
      	'System Administrator', 'Pricing Analyst', 'Sales Operations II', 'Reseller (Sales)',
      	'Contracts/Legal','Field Sales AE, AM, CSM (Sales)', 'Business Development (Sales)',      
      	'Client Service (Sales)', 'Sales Operations', 'Production Coordinator', 'Production Manager'
    };
        
    private static final Set<String> STATUSES_RESTRICT_TO_DRAFT = new Set<String>{
        'Custom Quote Approved', 'Custom Quote Rejected', 'Approved', 'Rejected' 
    };
        
    private static final String DRAFT_STATUS = 'Draft';
    private static final String DRAFT_STATUS_CHANGE_ERROR = 'Quote cannot be set Back to Draft from '
        + 'Custom Quote Requested status - contact your DDS Consultant.';
    private static final String DRAFT_STATUS_CHANGE_SUCCESS = 'Success';
    
    private static final String CURRENT_USER_PROFILE = [SELECT Name
                                                        FROM Profile
                                                        WHERE Id = :UserInfo.getProfileId()
                                                        LIMIT 1][0].Name;
    
    @AuraEnabled
    public static string updateQuote(SBQQ__Quote__c quote ){
        String result='';
        
        if (PROFILES_RESTRICT_TO_DRAFT.contains(CURRENT_USER_PROFILE) 
            || STATUSES_RESTRICT_TO_DRAFT.contains(quote.SBQQ__Status__c)){
            result = DRAFT_STATUS_CHANGE_ERROR;
        }else{
            quote.SBQQ__Status__c = DRAFT_STATUS;
            result = DRAFT_STATUS_CHANGE_SUCCESS;
        }
        
        return result;
    }
}
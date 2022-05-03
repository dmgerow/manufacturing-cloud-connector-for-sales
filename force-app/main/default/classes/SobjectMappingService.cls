public with sharing class SobjectMappingService {
    public static SObject mapFields(SObject source, SObject target) {
        Map<String, Schema.SObjectField> sourceFieldMap = SobjectUtilities.getFieldMap(
            source.getSObjectType()
        );
        Map<String, Schema.SObjectField> targetFieldMap = SobjectUtilities.getFieldMap(
            target.getSObjectType()
        );
        Map<String, Object> populatedFields = source.getPopulatedFieldsAsMap();
        for (String field : populatedFields.keySet()) {
            if (targetFieldMap.containsKey(field)) {
                if (target.Id == null && targetFieldMap.get(field).getDescribe().isCreateable()) {
                    target.put(field, populatedFields.get(field));
                } else if (
                    target.Id != null && targetFieldMap.get(field).getDescribe().isUpdateable()
                ) {
                    target.put(field, populatedFields.get(field));
                }
            }
        }
        return target;
    }
}

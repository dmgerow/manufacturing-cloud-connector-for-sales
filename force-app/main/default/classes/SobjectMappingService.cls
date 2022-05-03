public with sharing class SobjectMappingService {
    public static SObject mapFields(SObject source, SObject target) {
        Map<String, Schema.SObjectField> targetFieldMap = SobjectUtilities.getFieldMap(
            target.getSObjectType()
        );
        Set<String> populatedFields = source.getPopulatedFieldsAsMap().keySet();
        for (String caseSensitiveField : populatedFields) {
            String field = caseSensitiveField.toLowerCase();
            if (targetFieldMap.containsKey(field)) {
                if (target.Id == null && targetFieldMap.get(field).getDescribe().isCreateable()) {
                    target.put(field, source.get(field));
                } else if (
                    target.Id != null && targetFieldMap.get(field).getDescribe().isUpdateable()
                ) {
                    target.put(field, source.get(field));
                }
            }
        }
        return target;
    }
}

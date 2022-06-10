// Default mapping plugin for Quote Line to Sales Agreement Product
public with sharing class QuoteLineToSalesAgreementProductMapping implements FieldMappingConfiguration {
    private static Map<String, String> cachedSourceToTargetMapping;
    private static Set<String> cachedFieldsToSumOnMerge;
    private static Set<String> cachedFieldsToWeightedAverageOnMerge;

    public static Map<String, String> sourceToTargetMapping() {
        if (cachedSourceToTargetMapping == null) {
            getCustomMetadataValues();
        }
        return cachedSourceToTargetMapping;
    }
    public static Set<String> fieldsToSumOnMerge() {
        if (cachedFieldsToSumOnMerge == null) {
            getCustomMetadataValues();
        }
        return cachedFieldsToSumOnMerge;
    }
    public static Set<String> fieldsToWeightedAverageOnMerge() {
        if (cachedFieldsToWeightedAverageOnMerge == null) {
            getCustomMetadataValues();
        }
        return cachedFieldsToWeightedAverageOnMerge;
    }

    private static void getCustomMetadataValues() {
        cachedSourceToTargetMapping = new Map<String, String>();
        cachedFieldsToSumOnMerge = new Set<String>();
        cachedFieldsToWeightedAverageOnMerge = new Set<String>();
        for (QliToSapFieldMapping__mdt mapping : QliToSapFieldMapping__mdt.getAll().values()) {
            cachedSourceToTargetMapping.put(mapping.QliField__c, mapping.SapField__c);
            if (mapping.SumOnMerge__c) {
                cachedFieldsToSumOnMerge.add(mapping.SapField__c);
            }
            if (mapping.WeightedAverageOnMerge__c) {
                cachedFieldsToWeightedAverageOnMerge.add(mapping.SapField__c);
            }
        }
    }
}

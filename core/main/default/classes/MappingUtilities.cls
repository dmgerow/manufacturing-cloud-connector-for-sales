public with sharing class MappingUtilities {
    // Gets Quote Line to Sales Agreement Product Mappings. If plugin is not defined as a custom
    // setting then the default mappings are used.
    public static FieldMappingConfiguration qliToSapMapping {
        get {
            if (qliToSapMapping == null) {
                String className = SettingsUtilities.getQliToSapFieldMappingPlugin();
                Type mappingConfig = Type.forName(className);
                if (mappingConfig == null) {
                    throw new MappingException(
                        'The mapping plugin named \'' +
                        className +
                        '\' does not exist.'
                    );
                } else {
                    qliToSapMapping = (FieldMappingConfiguration) mappingConfig.newInstance();
                }
            }
            return qliToSapMapping;
        }
        private set;
    }

    public static String getQuoteLineQuoteApiName() {
        return SettingsUtilities.isCpqEnabled() ? 'SBQQ__Quote__c' : 'QuoteId';
    }

    public static String getPriceBookEntryIdApiName() {
        return SettingsUtilities.isCpqEnabled() ? 'SBQQ__PricebookEntryId__c' : 'PriceBookEntryId';
    }

    public static String getQuoteLineObjectApiName() {
        return SettingsUtilities.isCpqEnabled() ? 'SBQQ__QuoteLine__c' : 'QuoteLineItem';
    }

    public class MappingException extends Exception {
    }
}

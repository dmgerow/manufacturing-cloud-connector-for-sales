public with sharing class MappingUtilities {
    public static FieldMappingConfiguration qliToSapMapping {
        get {
            if (qliToSapMapping == null) {
                Settings__c packageSettings = Settings__c.getInstance();
                String className = packageSettings.QliToSapFieldMappingPlugin__c == null
                    ? 'QuoteLineToSalesAgreementProductMapping'
                    : packageSettings.QliToSapFieldMappingPlugin__c;
                qliToSapMapping = (FieldMappingConfiguration) Type.forName(className).newInstance();
            }
            return qliToSapMapping;
        }
        private set;
    }
}

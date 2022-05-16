public with sharing class MappingUtilities {
    public static FieldMappingConfiguration qliToSapMapping {
        get {
            if (qliToSapMapping == null) {
                Settings__c packageSettings = Settings__c.getInstance();
                String className = packageSettings.QliToSapFieldMappingPlugin__c == null
                    ? 'QuoteLineToSalesAgreementProductMapping'
                    : packageSettings.QliToSapFieldMappingPlugin__c;
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

    public class MappingException extends Exception {
    }
}

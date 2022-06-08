public with sharing class MappingUtilities {
    // Gets Quote Line to Sales Agreement Product Mappings. If plugin is not defined as a custom
    // setting then the default mappings are used.
    public static FieldMappingConfiguration qliToSapMapping {
        get {
            if (qliToSapMapping == null) {
                String className = SettingsUtilities.packageSettings.QliToSapFieldMappingPlugin__c ==
                    null
                    ? 'QuoteLineToSalesAgreementProductMapping'
                    : SettingsUtilities.packageSettings.QliToSapFieldMappingPlugin__c;
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

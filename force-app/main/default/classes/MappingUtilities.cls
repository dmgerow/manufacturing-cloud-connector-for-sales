public with sharing class MappingUtilities {
    public static FieldMappingConfiguration qliToSapMapping {
        get {
            if (qliToSapMapping == null) {
                qliToSapMapping = (FieldMappingConfiguration) Type.forName(
                        'QuoteLineToSalesAgreementProductMapping'
                    )
                    .newInstance();
            }
            return qliToSapMapping;
        }
        private set;
    }
}

public with sharing class MappingUtilities {
    public static Map<String, String> quoteLineToSalesAgreementProduct {
        get {
            if (quoteLineToSalesAgreementProduct == null) {
                quoteLineToSalesAgreementProduct = QuoteLineToSalesAgreementProductMapping.sourceToTargetMapping();
            }
            return quoteLineToSalesAgreementProduct;
        }
        private set;
    }
}

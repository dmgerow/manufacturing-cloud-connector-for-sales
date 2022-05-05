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
    public static Set<String> qliToSapFieldsToSum {
        get {
            if (qliToSapFieldsToSum == null) {
                qliToSapFieldsToSum = QuoteLineToSalesAgreementProductMapping.fieldsToSumOnMerge();
            }
            return qliToSapFieldsToSum;
        }
        private set;
    }
    public static Set<String> qliToSapFieldsToAvg {
        get {
            if (qliToSapFieldsToAvg == null) {
                qliToSapFieldsToAvg = QuoteLineToSalesAgreementProductMapping.fieldsToWeightedAverageOnMerge();
            }
            return qliToSapFieldsToAvg;
        }
        private set;
    }
}

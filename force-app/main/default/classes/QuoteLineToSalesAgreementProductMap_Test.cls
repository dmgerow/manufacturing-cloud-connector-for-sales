@isTest
private class QuoteLineToSalesAgreementProductMap_Test {
    @isTest
    static void mappingFile() {
        Test.startTest();
        System.assert(!QuoteLineToSalesAgreementProductMapping.sourceToTargetMapping().isEmpty());
        System.assert(!QuoteLineToSalesAgreementProductMapping.fieldsToSumOnMerge().isEmpty());
        System.assert(
            !QuoteLineToSalesAgreementProductMapping.fieldsToWeightedAverageOnMerge().isEmpty()
        );
        Test.stopTest();
    }
}

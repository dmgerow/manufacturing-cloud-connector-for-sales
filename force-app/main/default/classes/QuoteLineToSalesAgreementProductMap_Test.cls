@isTest
private class QuoteLineToSalesAgreementProductMap_Test {
    @isTest
    static void mappingFile() {
        System.runAs(TestUtilities.testUser) {
            Test.startTest();
            System.assert(
                !QuoteLineToSalesAgreementProductMapping.sourceToTargetMapping().isEmpty()
            );
            System.assert(!QuoteLineToSalesAgreementProductMapping.fieldsToSumOnMerge().isEmpty());
            System.assert(
                !QuoteLineToSalesAgreementProductMapping.fieldsToWeightedAverageOnMerge().isEmpty()
            );
            Test.stopTest();
        }
    }
}

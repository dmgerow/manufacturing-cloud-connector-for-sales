@isTest
private class SalesAgreementUtilities_Test {
    @isTest
    static void getQuoteIds() {
        SalesAgreement testAgreement = new SalesAgreement(
            Quote__c = TestUtilities.generateTestId(Quote.getSObjectType())
        );
        Test.startTest();
        Set<Id> quoteIds = SalesAgreementUtilities.getQuoteIds(
            new List<SalesAgreement>{ testAgreement }
        );
        Test.stopTest();
        System.assert(quoteIds.contains(testAgreement.Quote__c) && !quoteIds.isEmpty());
    }
}

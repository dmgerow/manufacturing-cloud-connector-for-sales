@isTest
private class SalesAgreementModel_Test {
    @isTest
    static void createSalesAgreementProducts() {
        SalesAgreement salesAgreement = new SalesAgreement(
            Id = TestUtilities.generateTestId(SalesAgreement.getSobjectType())
        );
        SalesAgreementModel model = new SalesAgreementModel(salesAgreement);
        QuoteLineItem qli = new QuoteLineItem(
            Id = TestUtilities.generateTestId(QuoteLineItem.getSobjectType()),
            Quantity = 1,
            UnitPrice = 2,
            PriceBookEntryId = TestUtilities.generateTestId(PricebookEntry.getSobjectType())
        );
        QuoteLineItem qli2 = new QuoteLineItem(
            Id = TestUtilities.generateTestId(QuoteLineItem.getSobjectType()),
            Quantity = 1,
            UnitPrice = 2,
            PriceBookEntryId = qli.PriceBookEntryId
        );
        Test.startTest();
        model.createSalesAgreementProducts(new List<QuoteLineItem>{ qli, qli2 });
        Test.stopTest();
        System.assert(model.salesAgreementProductsByPbe.containsKey(qli.PricebookEntryId));
    }
}

@isTest
private class QuoteToSalesAgreementAction_Test {
    @isTest
    static void createSalesAgreementProducts() {
        System.runAs(TestUtilities.testUser) {
            SalesAgreement testAgreement = TestUtilities.testSalesAgreement;
            QuoteLineItem qli = TestUtilities.testQuoteLine;
            QuoteLineItem qli2 = qli.clone(false, true, false, false);
            insert qli2;
            Test.startTest();
            QuoteToSalesAgreementAction.createSalesAgreementProducts(
                new List<SalesAgreement>{ testAgreement }
            );
            Test.stopTest();
            List<SalesAgreementProduct> saps = [
                SELECT InitialPlannedQuantity, SalesPrice
                FROM SalesAgreementProduct
                WHERE SalesAgreementId = :testAgreement.Id
            ];
            System.assertEquals(1, saps.size());

            System.assertEquals(2, saps[0].InitialPlannedQuantity);
            System.assertEquals(1000, saps[0].SalesPrice);
        }
    }

    @isTest
    static void throwException() {
        System.runAs(TestUtilities.testUser) {
            Test.startTest();
            try {
                QuoteToSalesAgreementAction.createSalesAgreementProducts(null);
                System.assert(false);
            } catch (Exception e) {
                System.assert(true);
            }
            Test.stopTest();
        }
    }
}

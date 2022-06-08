@isTest
private class QuoteToSalesAgreementService_Test {
    @isTest
    static void createSalesAgreementProducts() {
        System.runAs(TestUtilities.testUser) {
            SalesAgreement testAgreement = TestUtilities.testSalesAgreement;
            QuoteLineItem qli = TestUtilities.testQuoteLine;
            QuoteLineItem qli2 = qli.clone(false, true, false, false);
            insert qli2;
            Test.startTest();
            QuoteToSalesAgreementService.createSalesAgreementProducts(
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
    static void createSalesAgreementProductsMatchQuotes() {
        System.runAs(TestUtilities.testUser) {
            insert new Settings__c(MatchQliAccountToSaAccount__c = true);
            Account testAccount2 = TestUtilities.testAccount.clone(false, true, false, false);
            insert testAccount2;
            SalesAgreement testAgreement = TestUtilities.testSalesAgreement;
            SalesAgreement testAgreement2 = testAgreement.clone(false, true, false, false);
            testAgreement2.AccountId = testAccount2.Id;
            insert testAgreement2;
            QuoteLineItem qli = TestUtilities.testQuoteLine;
            QuoteLineItem qli2 = qli.clone(false, true, false, false);
            qli2.AccountId__c = testAccount2.Id;
            insert qli2;
            Test.startTest();
            QuoteToSalesAgreementService.createSalesAgreementProducts(
                new List<SalesAgreement>{ testAgreement, testAgreement2 }
            );
            Test.stopTest();
            List<SalesAgreementProduct> saps = [
                SELECT InitialPlannedQuantity, SalesPrice
                FROM SalesAgreementProduct
                WHERE SalesAgreementId = :testAgreement.Id
            ];
            System.assertEquals(1, saps.size());

            System.assertEquals(1, saps[0].InitialPlannedQuantity);
            System.assertEquals(1000, saps[0].SalesPrice);

            List<SalesAgreementProduct> saps2 = [
                SELECT InitialPlannedQuantity, SalesPrice
                FROM SalesAgreementProduct
                WHERE SalesAgreementId = :testAgreement2.Id
            ];
            System.assertEquals(1, saps2.size());

            System.assertEquals(1, saps2[0].InitialPlannedQuantity);
            System.assertEquals(1000, saps2[0].SalesPrice);
        }
    }
}

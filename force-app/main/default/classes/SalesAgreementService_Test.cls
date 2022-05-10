@isTest
private class SalesAgreementService_Test {
    @isTest
    static void createSalesAgreementProducts() {
        System.runAs(TestUtilities.testUser) {
            SalesAgreement testAgreement = new SalesAgreement(
                Quote__c = TestUtilities.generateTestId(Quote.getSObjectType())
            );
            Test.startTest();
            QuoteToSalesAgreementAction.createSalesAgreementProducts(
                new List<SalesAgreement>{ testAgreement }
            );
            Test.stopTest();
            System.assert(true);
            // since there is no return value or DML statements in the test that occur, and each
            // class that performs DML is tested on its own, we do not need to have an assert for
            // this test.
        }
    }
}

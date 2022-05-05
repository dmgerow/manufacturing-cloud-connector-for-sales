global with sharing class QuoteToSalesAgreementAction {
    @InvocableMethod(
        label='Create Sales Agreement Products from Quote'
        description='Creates Sales Agreement Products and Schedules from a Quote.'
        category='Manufacturing Cloud'
    )
    global static void createSalesAgreementProducts(List<SalesAgreement> salesAgreements) {
        try {
            SalesAgreementService.createSalesAgreementProducts(salesAgreements);
        } catch (Exception e) {
            throw new QuoteToSalesAgreementActionException(e.getMessage());
        }
    }

    public class QuoteToSalesAgreementActionException extends Exception {
    }
}

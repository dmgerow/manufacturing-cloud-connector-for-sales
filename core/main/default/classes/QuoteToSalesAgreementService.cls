@SuppressWarnings('PMD.AvoidGlobalModifier')
global with sharing class QuoteToSalesAgreementService {
    // Global method to invoke quote line to sales agreement product conversion via Apex
    global static void createSalesAgreementProducts(List<SalesAgreement> newSalesAgreements) {
        SalesAgreementService.createSalesAgreementProducts(newSalesAgreements);
    }
}

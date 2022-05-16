@SuppressWarnings('PMD.AvoidGlobalModifier')
global with sharing class QuoteToSalesAgreementService {
    global static void createSalesAgreementProducts(List<SalesAgreement> newSalesAgreements) {
        SalesAgreementService.createSalesAgreementProducts(newSalesAgreements);
    }
}

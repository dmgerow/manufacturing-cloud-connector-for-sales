global with sharing class QuoteToSalesAgreementAction {
    @InvocableMethod(
        label='Create Sales Agreement Products from Quote'
        description='Creates Sales Agreement Products and Schedules from a Quote.'
        category='Manufacturing Cloud'
    )
    global static void createSalesAgreementProducts(List<SalesAgreement> salesAgreements) {
        System.debug(JSON.serializePretty(salesAgreements));
        Map<Id, List<QuoteLineItem>> quoteLinesByQuoteId = getQuoteLinesByQuoteId(
            SalesAgreementUtilities.getQuoteIds(salesAgreements)
        );
        List<SalesAgreementProduct> salesAgreementProducts = new List<SalesAgreementProduct>();
        for (SalesAgreement salesAgreement : salesAgreements) {
            SalesAgreementModel agreementModel = new SalesAgreementModel(salesAgreement);
            agreementModel.createSalesAgreementProducts(
                quoteLinesByQuoteId.get(salesAgreement.Quote__c)
            );
            salesAgreementProducts.addAll(agreementModel.salesAgreementProducts);
        }
        System.debug(JSON.serializePretty(salesAgreementProducts));
        insert salesAgreementProducts;
    }

    public static Map<Id, List<QuoteLineItem>> getQuoteLinesByQuoteId(Set<Id> quoteIds) {
        Map<Id, List<QuoteLineItem>> quoteLinesByQuoteId = new Map<Id, List<QuoteLineItem>>();
        for (QuoteLineItem lineItem : [
            SELECT FIELDS(STANDARD)
            FROM QuoteLineItem
            WHERE QuoteId IN :quoteIds
            WITH SECURITY_ENFORCED
        ]) {
            List<QuoteLineItem> lineItems = new List<QuoteLineItem>{ lineItem };
            if (quoteLinesByQuoteId.containsKey(lineItem.QuoteId)) {
                lineItems.addAll(quoteLinesByQuoteId.get(lineItem.QuoteId));
            }
            quoteLinesByQuoteId.put(lineItem.QuoteId, lineItems);
        }
        return quoteLinesByQuoteId;
    }
}

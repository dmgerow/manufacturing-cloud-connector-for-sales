global with sharing class QuoteToSalesAgreementAction {
    @InvocableMethod(
        label='Create Sales Agreement Products'
        description='Creates Sales Agreement Products and Schedules from a Quote. Returns created Sales Agreement(s).'
        category='Manufacturing Cloud'
    )
    global static void createSalesAgreementProducts(List<Id> salesAgreementIds) {
        List<SalesAgreement> salesAgreements = getSalesAgreements(salesAgreementIds);
        Map<Id, List<QuoteLineItem>> quoteLinesByQuoteId = getQuoteLinesByQuoteId(
            SalesAgreementUtilities.getQuoteIds(salesAgreements)
        );
    }

    public static List<SalesAgreement> getSalesAgreements(List<Id> salesAgreementIds) {
        return [
            SELECT Quote__c
            FROM SalesAgreement
            WHERE Id IN :salesAgreementIds
            WITH SECURITY_ENFORCED
        ];
    }

    public static Map<Id, List<QuoteLineItem>> getQuoteLinesByQuoteId(Set<Id> quoteIds) {
        Map<Id, List<QuoteLineItem>> quoteLinesByQuoteId = new Map<Id, List<QuoteLineItem>>();
        for (QuoteLineItem lineItem : [
            SELECT FIELDS(STANDARD)
            FROM QuoteLineItem
            WHERE Id IN :quoteIds
            WITH SECURITY_ENFORCED
        ]) {
            List<QuoteLineItem> lineItems = new List<QuoteLineItem>();
            if (quoteLinesByQuoteId.containsKey(lineItem.QuoteId)) {
                lineItems.addAll(quoteLinesByQuoteId.get(lineItem.QuoteId));
            }
        }
        return quoteLinesByQuoteId;
    }
}

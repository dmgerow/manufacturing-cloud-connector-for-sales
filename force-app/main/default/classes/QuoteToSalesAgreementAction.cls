public with sharing class QuoteToSalesAgreementAction {
    @InvocableMethod(
        label='Create Sales Agreement'
        description='Creates Sales Agreement(s) from a Quote. Returns created Sales Agreement(s).'
        category='Manufacturing Cloud'
    )
    public static List<SalesAgreement> createSalesAgreements(List<Id> quoteIds) {
        List<Quote> quotes = QuoteSelector.getQuotes(quoteIds);
        List<SalesAgreement> newSalesAgreements = new List<SalesAgreement>();
        List<SalesAgreementProduct> newSalesAgreementProducts = new List<SalesAgreementProduct>();
        for (Quote quote : quotes) {
            SalesAgreementModel agreementModel = SalesAgreementService.createSalesAgreement(quote);
        }
        insert newSalesAgreements;
        return newSalesAgreements;
    }
}

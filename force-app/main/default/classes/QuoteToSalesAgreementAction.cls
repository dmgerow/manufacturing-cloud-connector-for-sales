public with sharing class QuoteToSalesAgreementAction {
    @InvocableMethod(
        label='Create Sales Agreement'
        description='Creates Sales Agreement(s) from a Quote. Returns created Sales Agreement(s).'
        category='Manufacturing Cloud'
    )
    public static List<SalesAgreement> createSalesAgreements(List<Id> quoteIds) {
        List<Quote> quotes = QuoteSelector.getQuotes(quoteIds);
        List<SalesAgreement> newSalesAgreements = new List<SalesAgreement>();
        List<SalesAgreementModel> newSalesAgreementModels = new List<SalesAgreementModel>();
        for (Quote quote : quotes) {
            SalesAgreementModel agreementModel = new SalesAgreementModel();
            agreementModel.createSalesAgreement(quote);
            newSalesAgreements.add(agreementModel.salesAgreement);
        }
        insert newSalesAgreements;
        return newSalesAgreements;
    }
}

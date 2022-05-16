@namespaceAccessible
public with sharing class SalesAgreementUtilities {
    @namespaceAccessible
    public static Set<Id> getQuoteIds(List<SalesAgreement> salesAgreements) {
        Set<Id> quoteIds = new Set<Id>();
        for (SalesAgreement salesAgreement : salesAgreements) {
            if (salesAgreement.Quote__c != null) {
                quoteIds.add(salesAgreement.Quote__c);
            }
        }
        return quoteIds;
    }
}

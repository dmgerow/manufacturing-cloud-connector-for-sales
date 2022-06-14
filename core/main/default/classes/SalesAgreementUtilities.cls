@namespaceAccessible
public with sharing class SalesAgreementUtilities {
    @namespaceAccessible
    public static Set<Id> getQuoteIds(List<SalesAgreement> salesAgreements) {
        Set<Id> quoteIds = new Set<Id>();
        for (SalesAgreement salesAgreement : salesAgreements) {
            if (salesAgreement.get(SettingsUtilities.getSalesAgreementQuoteField()) != null) {
                quoteIds.add(
                    (Id) salesAgreement.get(SettingsUtilities.getSalesAgreementQuoteField())
                );
            }
        }
        return quoteIds;
    }
}

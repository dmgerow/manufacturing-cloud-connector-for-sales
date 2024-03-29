public with sharing class SalesAgreementService {
    public static void createSalesAgreementProducts(List<SalesAgreement> salesAgreements) {
        Map<Id, List<QuoteLineItem>> quoteLinesByQuoteId = getQuoteLinesByQuoteId(
            SalesAgreementUtilities.getQuoteIds(salesAgreements)
        );
        List<SalesAgreementProduct> salesAgreementProducts = new List<SalesAgreementProduct>();
        for (SalesAgreement salesAgreement : salesAgreements) {
            SalesAgreementModel agreementModel = new SalesAgreementModel(salesAgreement);
            agreementModel.createSalesAgreementProducts(
                quoteLinesByQuoteId.get(salesAgreement.Quote__c)
            );
            salesAgreementProducts.addAll(agreementModel.salesAgreementProductsByPbe.values());
        }
        SObjectAccessDecision securityDecision = Security.stripInaccessible(
            AccessType.CREATABLE,
            salesAgreementProducts
        );
        insert securityDecision.getRecords();
    }

    public static Map<Id, List<QuoteLineItem>> getQuoteLinesByQuoteId(Set<Id> quoteIds) {
        Map<Id, List<QuoteLineItem>> quoteLinesByQuoteId = new Map<Id, List<QuoteLineItem>>();
        for (
            QuoteLineItem lineItem : Database.query(
                QueryUtilities.getFieldString(
                    MappingUtilities.qliToSapMapping.sourceToTargetMapping().keySet()
                ) + ' FROM QuoteLineItem WHERE QuoteId IN :quoteIds WITH SECURITY_ENFORCED'
            )
        ) {
            List<QuoteLineItem> lineItems = new List<QuoteLineItem>{ lineItem };
            if (quoteLinesByQuoteId.containsKey(lineItem.QuoteId)) {
                lineItems.addAll(quoteLinesByQuoteId.get(lineItem.QuoteId));
            }
            quoteLinesByQuoteId.put(lineItem.QuoteId, lineItems);
        }
        return quoteLinesByQuoteId;
    }
}

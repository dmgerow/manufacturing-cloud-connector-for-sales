public with sharing class SalesAgreementService {
    public static void createSalesAgreementProducts(List<SalesAgreement> salesAgreements) {
        Map<Id, List<QuoteLineItem>> quoteLinesByQuoteId = getQuoteLinesByQuoteId(
            SalesAgreementUtilities.getQuoteIds(salesAgreements)
        );
        List<SalesAgreementProduct> salesAgreementProducts = new List<SalesAgreementProduct>();
        for (SalesAgreement salesAgreement : salesAgreements) {
            SalesAgreementModel agreementModel = new SalesAgreementModel(salesAgreement);
            agreementModel.createSalesAgreementProducts(
                quoteLinesByQuoteId.get(
                    (Id) salesAgreement.get(SettingsUtilities.getSalesAgreementQuoteField())
                )
            );
            salesAgreementProducts.addAll(agreementModel.salesAgreementProductsByPbe.values());
        }
        SObjectAccessDecision securityDecision = Security.stripInaccessible(
            AccessType.CREATABLE,
            salesAgreementProducts
        );
        insert securityDecision.getRecords();
    }

    public static Map<Id, List<SObject>> getQuoteLinesByQuoteId(Set<Id> quoteIds) {
        Map<Id, List<SObject>> quoteLinesByQuoteId = new Map<Id, List<SObject>>();
        for (
            SObject lineItem : Database.query(
                QueryUtilities.getFieldString(
                    MappingUtilities.qliToSapMapping.sourceToTargetMapping().keySet()
                ) +
                ' FROM ' +
                MappingUtilities.getQuoteLineObjectApiName() +
                ' WHERE ' +
                MappingUtilities.getQuoteLineQuoteApiName() +
                ' IN :quoteIds WITH SECURITY_ENFORCED'
            )
        ) {
            List<Sobject> lineItems = new List<Sobject>{ lineItem };
            if (
                quoteLinesByQuoteId.containsKey(
                    (Id) lineItem.get(MappingUtilities.getQuoteLineQuoteApiName())
                )
            ) {
                lineItems.addAll(
                    quoteLinesByQuoteId.get(
                        (Id) lineItem.get(MappingUtilities.getQuoteLineQuoteApiName())
                    )
                );
            }
            quoteLinesByQuoteId.put(
                (Id) lineItem.get(MappingUtilities.getQuoteLineQuoteApiName()),
                lineItems
            );
        }
        return quoteLinesByQuoteId;
    }
}

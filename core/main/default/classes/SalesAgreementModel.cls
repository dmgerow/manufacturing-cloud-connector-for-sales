public with sharing class SalesAgreementModel {
    public SalesAgreement salesAgreement;
    public Map<Id, SalesAgreementProduct> salesAgreementProductsByPbe;

    public salesAgreementModel(SalesAgreement salesAgreement) {
        this.salesAgreement = salesAgreement;
        this.salesAgreementProductsByPbe = new Map<Id, SalesAgreementProduct>();
    }

    // creates sales agreement products from quote lines
    public void createSalesAgreementProducts(List<QuoteLineItem> quoteLineItems) {
        if (quoteLineItems == null) {
            return;
        }
        this.salesAgreementProductsByPbe = new Map<Id, SalesAgreementProduct>();
        for (QuoteLineItem quoteLine : quoteLineItems) {
            if (
                SettingsUtilities.packageSettings.MatchQliAccountToSaAccount__c &&
                quoteLine.AccountId__c != salesAgreement.AccountId
            ) {
                continue;
            }
            SalesAgreementProduct salesAgreementProduct = new SalesAgreementProduct();
            salesAgreementProduct.SalesAgreementId = salesAgreement.Id;
            mapFieldsFromQuoteLine(quoteLine, salesAgreementProduct);
            // a price book entry can only exist on a sales agreements once
            if (
                this.salesAgreementProductsByPbe.containsKey(salesAgreementProduct.PriceBookEntryId)
            ) {
                salesAgreementProduct = mergeAgreementProducts(
                    salesAgreementProduct,
                    this.salesAgreementProductsByPbe.get(salesAgreementProduct.PriceBookEntryId)
                );
            }
            this.salesAgreementProductsByPbe.put(
                salesAgreementProduct.PriceBookEntryId,
                salesAgreementProduct
            );
        }
    }

    public void mapFieldsFromQuoteLine(
        QuoteLineItem quoteLine,
        SalesAgreementProduct salesAgreementProduct
    ) {
        for (
            String sourceField : MappingUtilities.qliToSapMapping.sourceToTargetMapping().keySet()
        ) {
            if (
                MappingUtilities.qliToSapMapping.sourceToTargetMapping().get(sourceField) ==
                'InitialPlannedQuantity'
            ) {
                // InitialPlannedQuantity is an integer
                salesAgreementProduct.put(
                    MappingUtilities.qliToSapMapping.sourceToTargetMapping().get(sourceField),
                    Integer.valueOf(quoteLine.get(sourceField))
                );
            } else {
                salesAgreementProduct.put(
                    MappingUtilities.qliToSapMapping.sourceToTargetMapping().get(sourceField),
                    quoteLine.get(sourceField)
                );
            }
        }
    }

    public SalesAgreementProduct mergeAgreementProducts(
        SalesAgreementProduct newAgrementProduct,
        SalesAgreementProduct existingAgreementProduct
    ) {
        for (String field : MappingUtilities.qliToSapMapping.fieldsToWeightedAverageOnMerge()) {
            Decimal value =
                ((Decimal) existingAgreementProduct.get(field) *
                existingAgreementProduct.InitialPlannedQuantity +
                (Decimal) newAgrementProduct.get(field) *
                newAgrementProduct.InitialPlannedQuantity) /
                (existingAgreementProduct.InitialPlannedQuantity +
                newAgrementProduct.InitialPlannedQuantity);
            existingAgreementProduct.put(field, value);
        }
        for (String field : MappingUtilities.qliToSapMapping.fieldsToSumOnMerge()) {
            Decimal value =
                (Decimal) existingAgreementProduct.get(field) +
                (Decimal) newAgrementProduct.get(field);
            if (field == 'InitialPlannedQuantity') {
                // InitialPlannedQuantity is an integer
                existingAgreementProduct.put(field, Integer.valueOf(value));
            } else {
                existingAgreementProduct.put(field, value);
            }
        }
        return existingAgreementProduct;
    }
}

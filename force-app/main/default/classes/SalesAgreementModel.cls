public with sharing class SalesAgreementModel {
    public SalesAgreement salesAgreement;
    public Map<Id, SalesAgreementProduct> salesAgreementProductsByPbe;

    public salesAgreementModel(SalesAgreement salesAgreement) {
        this.salesAgreement = salesAgreement;
        this.salesAgreementProductsByPbe = new Map<Id, SalesAgreementProduct>();
    }

    public void createSalesAgreementProducts(List<QuoteLineItem> quoteLineItems) {
        if (quoteLineItems == null) {
            return;
        }
        this.salesAgreementProductsByPbe = new Map<Id, SalesAgreementProduct>();
        for (QuoteLineItem quoteLine : quoteLineItems) {
            SalesAgreementProduct salesAgreementProduct = new SalesAgreementProduct();
            salesAgreementProduct.SalesAgreementId = salesAgreement.Id;
            mapFieldsFromQuoteLine(quoteLine, salesAgreementProduct);
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
        for (String sourceField : MappingUtilities.quoteLineToSalesAgreementProduct.keySet()) {
            if (
                MappingUtilities.quoteLineToSalesAgreementProduct.get(sourceField) ==
                'InitialPlannedQuantity'
            ) {
                salesAgreementProduct.put(
                    MappingUtilities.quoteLineToSalesAgreementProduct.get(sourceField),
                    Integer.valueOf(quoteLine.get(sourceField))
                );
            } else {
                salesAgreementProduct.put(
                    MappingUtilities.quoteLineToSalesAgreementProduct.get(sourceField),
                    quoteLine.get(sourceField)
                );
            }
        }
    }

    public SalesAgreementProduct mergeAgreementProducts(
        SalesAgreementProduct newAgrementProduct,
        SalesAgreementProduct existingAgreementProduct
    ) {
        for (String field : MappingUtilities.qliToSapFieldsToAvg) {
            Decimal value =
                ((Decimal) existingAgreementProduct.get(field) *
                existingAgreementProduct.InitialPlannedQuantity +
                (Decimal) newAgrementProduct.get(field) *
                newAgrementProduct.InitialPlannedQuantity) /
                (existingAgreementProduct.InitialPlannedQuantity +
                newAgrementProduct.InitialPlannedQuantity);
            existingAgreementProduct.put(field, value);
        }
        for (String field : MappingUtilities.qliToSapFieldsToSum) {
            Decimal value =
                (Decimal) existingAgreementProduct.get(field) +
                (Decimal) newAgrementProduct.get(field);
            if (field == 'InitialPlannedQuantity') {
                existingAgreementProduct.put(field, Integer.valueOf(value));
            } else {
                existingAgreementProduct.put(field, value);
            }
        }
        return existingAgreementProduct;
    }
}

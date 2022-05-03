public with sharing class SalesAgreementModel {
    public SalesAgreement salesAgreement;
    public List<SalesAgreementProduct> salesAgreementProducts;

    public salesAgreementModel(SalesAgreement salesAgreement) {
        this.salesAgreement = salesAgreement;
        this.salesAgreementProducts = new List<SalesAgreementProduct>();
    }

    public void createSalesAgreementProducts(List<QuoteLineItem> quoteLineItems) {
        if (quoteLineItems == null) {
            return;
        }
        this.salesAgreementProducts = new List<SalesAgreementProduct>();
        for (QuoteLineItem quoteLine : quoteLineItems) {
            SalesAgreementProduct salesAgreementProduct = new SalesAgreementProduct();
            salesAgreementProduct = (SalesAgreementProduct) SobjectMappingService.mapFields(
                quoteLine,
                salesAgreementProduct
            );
            salesAgreementProduct.SalesAgreementId = salesAgreement.Id;
            salesAgreementProduct.Name = 'product name';
            salesAgreementProduct.InitialPlannedQuantity = Integer.valueOf(quoteLine.Quantity);
            salesAgreementProduct.SalesPrice = quoteLine.UnitPrice;
            salesAgreementProducts.add(salesAgreementProduct);
        }
    }
}

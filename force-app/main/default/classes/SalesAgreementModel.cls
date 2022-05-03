public with sharing class SalesAgreementModel {
    public SalesAgreement salesAgreement;
    public List<SalesAgreementProduct> salesAgreementProducts;

    public salesAgreementModel() {
        this.salesAgreementProducts = new List<SalesAgreementProduct>();
    }

    public void createSalesAgreement(SObject quote) {
        this.salesAgreement = new SalesAgreement();
        this.salesAgreement = (SalesAgreement) SobjectMappingService.mapFields(
            quote,
            this.salesAgreement
        );
    }
}

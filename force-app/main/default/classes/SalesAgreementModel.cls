public with sharing class SalesAgreementModel {
    public SalesAgreement salesAgreement;
    public List<SalesAgreementProduct> salesAgreementProducts;

    public salesAgreementModel() {
        this.salesAgreementProducts = new List<SalesAgreementProduct>();
    }
}

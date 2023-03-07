QuoteToSalesAgreementService.createSalesAgreementProducts(
  [
    SELECT AccountId, Quote__c, SalesAgreementKey__c
    FROM SalesAgreement
    WHERE Id IN ('0YA7g0000004C9SGAU', '0YA7g0000004C9XGAU')
  ]
);

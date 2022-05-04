public with sharing class QuoteLineToSalesAgreementProductMapping implements FieldMappingConfiguration {
    public static Map<String, String> sourceToTargetMapping() {
        return new Map<String, String>{
            'PriceBookEntryId' => 'PriceBookEntryId',
            'ProductName__c' => 'Name',
            'QuantityInteger__c' => 'InitialPlannedQuantity',
            'UnitPrice' => 'SalesPrice'
        };
    }
}

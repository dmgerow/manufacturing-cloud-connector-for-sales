public with sharing class QuoteLineToSalesAgreementProductMapping implements FieldMappingConfiguration {
    public static Map<String, String> sourceToTargetMapping() {
        return new Map<String, String>{
            'PriceBookEntryId' => 'PriceBookEntryId',
            'ProductName__c' => 'Name',
            'Quantity' => 'InitialPlannedQuantity',
            'UnitPrice' => 'SalesPrice'
        };
    }
    public static Set<String> fieldsToSumOnMerge() {
        return new Set<String>{ 'InitialPlannedQuantity' };
    }
    public static Set<String> fieldsToWeightedAverageOnMerge() {
        return new Set<String>{ 'SalesPrice' };
    }
}

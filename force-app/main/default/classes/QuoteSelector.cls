public with sharing class QuoteSelector {
    public static List<Quote> getQuotes(List<Id> quoteIds) {
        return [
            SELECT FIELDS(STANDARD), (SELECT FIELDS(STANDARD) FROM QuoteLineItems)
            FROM Quote
            WHERE Id IN :quoteIds
            WITH SECURITY_ENFORCED
        ];
    }
}

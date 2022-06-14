@namespaceAccessible
public with sharing class QueryUtilities {
    @namespaceAccessible
    public static String getFieldString(Set<String> fields) {
        Set<String> allFields = new Set<String>{
            MappingUtilities.getQuoteLineQuoteApiName(),
            SettingsUtilities.getQuoteLineAccountField(),
            MappingUtilities.getPriceBookEntryIdApiName()
        };
        allFields.addAll(fields);
        String queryString = 'SELECT ';
        for (String field : allFields) {
            queryString += field + ', ';
        }
        queryString = queryString.removeEnd(', ') + ' ';
        return queryString;
    }
}

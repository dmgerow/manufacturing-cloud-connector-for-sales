public with sharing class QueryUtilities {
    public static String getFieldString(Set<String> fields) {
        String queryString = 'SELECT ';
        for (String field : fields) {
            queryString += field + ', ';
        }
        queryString = queryString.removeEnd(', ') + ' ';
        return queryString;
    }
}
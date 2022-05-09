@isTest
private class QueryUtilities_Test {
    @isTest
    static void getFieldString() {
        Test.startTest();
        System.assertEquals(
            'SELECT Id, Name ',
            QueryUtilities.getFieldString(new Set<String>{ 'Id', 'Name' })
        );
        Test.stopTest();
    }
}

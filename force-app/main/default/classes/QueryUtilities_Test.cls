@isTest
private class QueryUtilities_Test {
    @isTest
    static void getFieldString() {
        System.runAs(TestUtilities.testUser) {
            Test.startTest();
            System.assertEquals(
                'SELECT Id, Name ',
                QueryUtilities.getFieldString(new Set<String>{ 'Id', 'Name' })
            );
            Test.stopTest();
        }
    }
}

@isTest
private class SobjectUtilities_Test {
    @isTest
    static void getFieldMap() {
        Test.startTest();
        System.assert(SobjectUtilities.getFieldMap(Account.getSObjectType()).size() > 0);
        Test.stopTest();
    }
}

@isTest
private class SobjectUtilities_Test {
    @isTest
    static void getFieldMap() {
        System.assert(SobjectUtilities.getFieldMap(Account.getSObjectType()).size() > 0);
    }
}

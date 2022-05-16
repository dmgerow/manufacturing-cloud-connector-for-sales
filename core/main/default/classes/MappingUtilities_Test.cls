@isTest
private class MappingUtilities_Test {
    @isTest
    static void qliToSapMapping() {
        System.runAs(TestUtilities.testUser) {
            Test.startTest();
            System.assert(!MappingUtilities.qliToSapMapping.sourceToTargetMapping().isEmpty());
            System.assert(!MappingUtilities.qliToSapMapping.fieldsToSumOnMerge().isEmpty());
            System.assert(
                !MappingUtilities.qliToSapMapping.fieldsToWeightedAverageOnMerge().isEmpty()
            );
            Test.stopTest();
        }
    }
}

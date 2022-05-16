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

    @isTest
    static void invalidQliToSapMapping() {
        System.runAs(TestUtilities.testUser) {
            insert new Settings__c(QliToSapFieldMappingPlugin__c = 'qwerty');
            Test.startTest();
            try {
                FieldMappingConfiguration mapping = MappingUtilities.qliToSapMapping;
                System.assert(false);
            } catch (Exception e) {
                System.assert(e.getMessage().contains('qwerty'));
            }
            Test.stopTest();
        }
    }
}

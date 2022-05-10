@isTest
public class TestUtilities {
    private static Integer recordNumber = 1;

    @TestVisible
    private static String generateTestId(Schema.SObjectType sObjectType) {
        String recordNumber = String.valueOf(recordNumber++);
        return sObjectType.getDescribe().getKeyPrefix() +
            '0'.repeat(12 - recordNumber.length()) +
            recordNumber;
    }

    @TestVisible
    private static User testUser {
        get {
            if (testUser == null) {
                Profile p = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
                testUser = new User(
                    Alias = 'standt',
                    Email = 'mfgcloudconnectorforsales@example.com',
                    EmailEncodingKey = 'UTF-8',
                    LastName = 'Testing',
                    LanguageLocaleKey = 'en_US',
                    LocaleSidKey = 'en_US',
                    ProfileId = p.Id,
                    TimeZoneSidKey = 'America/Los_Angeles',
                    UserName = 'mfgcloudconnectorforsales@example.com'
                );
                insert testUser;
                List<PermissionSetAssignment> assignments = new List<PermissionSetAssignment>();
                for (PermissionSet ps : [
                    SELECT Id
                    FROM PermissionSet
                    WHERE
                        Name IN (
                            'ManufacturingSalesAgreementsPsl',
                            'ManufacturingCloudConnecterForSales'
                        )
                ]) {
                    assignments.add(
                        new PermissionSetAssignment(
                            AssigneeId = testUser.Id,
                            PermissionSetId = ps.Id
                        )
                    );
                }
                insert assignments;
            }
            return testUser;
        }
        private set;
    }
}

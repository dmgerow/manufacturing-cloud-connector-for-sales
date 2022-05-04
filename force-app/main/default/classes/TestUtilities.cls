@isTest
public class TestUtilities {
    private static Integer recordNumber = 1;

    public static String generateTestId(Schema.SObjectType sObjectType) {
        String recordNumber = String.valueOf(recordNumber++);
        return sObjectType.getDescribe().getKeyPrefix() +
            '0'.repeat(12 - recordNumber.length()) +
            recordNumber;
    }
}

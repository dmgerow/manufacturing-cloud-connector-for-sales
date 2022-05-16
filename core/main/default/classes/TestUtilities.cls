@isTest
@namespaceAccessible
public class TestUtilities {
    private static Integer recordNumber = 1;

    @namespaceAccessible
    public static Account testAccount {
        get {
            if (testAccount == null) {
                testAccount = new Account(Name = 'Test Account');
                insert testAccount;
            }
            return testAccount;
        }
        private set;
    }

    @namespaceAccessible
    public static Opportunity testOpportunity {
        get {
            if (testOpportunity == null) {
                testOpportunity = new Opportunity(
                    Name = 'Large Container',
                    StageName = 'Prospecting',
                    CloseDate = Date.today(),
                    AccountId = testAccount.Id,
                    Pricebook2Id = Test.getStandardPricebookId()
                );
                insert testOpportunity;
            }
            return testOpportunity;
        }
        private set;
    }

    @namespaceAccessible
    public static Quote testQuote {
        get {
            if (testQuote == null) {
                testQuote = new Quote(
                    Name = 'My Quote',
                    OpportunityId = testOpportunity.Id,
                    Pricebook2Id = Test.getStandardPricebookId()
                );
                insert testQuote;
            }
            return testQuote;
        }
        private set;
    }

    @namespaceAccessible
    public static SalesAgreement testSalesAgreement {
        get {
            if (testSalesAgreement == null) {
                testSalesAgreement = new SalesAgreement(
                    Name = 'Test',
                    AccountId = testAccount.Id,
                    Quote__c = testQuote.Id,
                    StartDate = Date.today(),
                    ScheduleFrequency = 'Monthly',
                    ProductLevel = 'Product',
                    ScheduleCount = 12,
                    PricebookId = Test.getStandardPricebookId()
                );
                insert testSalesAgreement;
            }
            return testSalesAgreement;
        }
        private set;
    }

    @namespaceAccessible
    public static Product2 testProduct {
        get {
            if (testProduct == null) {
                testProduct = new Product2(Name = 'Large Container', IsActive = true);
                insert testProduct;
            }
            return testProduct;
        }
        private set;
    }

    @namespaceAccessible
    public static PricebookEntry testPbe {
        get {
            if (testPbe == null) {
                testPbe = new PricebookEntry(
                    Pricebook2Id = Test.getStandardPricebookId(),
                    Product2Id = testProduct.Id,
                    UnitPrice = 1000,
                    IsActive = true,
                    UseStandardPrice = false
                );
                insert testPbe;
            }
            return testPbe;
        }
        private set;
    }

    @namespaceAccessible
    public static QuoteLineItem testQuoteLine {
        get {
            if (testQuoteLine == null) {
                testQuoteLine = new QuoteLineItem(
                    QuoteId = testQuote.Id,
                    PricebookEntryId = testPbe.Id,
                    UnitPrice = 1000,
                    Quantity = 1
                );
                insert testQuoteLine;
            }
            return testQuoteLine;
        }
        private set;
    }

    @namespaceAccessible
    public static String generateTestId(Schema.SObjectType sObjectType) {
        String recordNumber = String.valueOf(recordNumber++);
        return sObjectType.getDescribe().getKeyPrefix() +
            '0'.repeat(12 - recordNumber.length()) +
            recordNumber;
    }

    @namespaceAccessible
    public static User testUser {
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

@isTest
private class SettingsUtilities_Test {
    @isTest
    static void isCpqEnabled() {
        System.assertEquals(false, SettingsUtilities.isCpqEnabled());
    }

    @isTest
    static void getQliToSapFieldMappingPlugin() {
        System.assertEquals(
            'QuoteLineToSalesAgreementProductMapping',
            SettingsUtilities.getQliToSapFieldMappingPlugin()
        );
    }

    @isTest
    static void getQuoteLineAccountField() {
        System.assertEquals('AccountId__c', SettingsUtilities.getQuoteLineAccountField());
    }

    @isTest
    static void getSalesAgreementQuoteField() {
        System.assertEquals('Quote__c', SettingsUtilities.getSalesAgreementQuoteField());
    }

    @isTest
    static void isMatchQliAccountToSaAccount() {
        System.assertEquals(false, SettingsUtilities.isMatchQliAccountToSaAccount());
    }
}

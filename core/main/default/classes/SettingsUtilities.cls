@namespaceAccessible
public with sharing class SettingsUtilities {
    public static Settings__c packageSettings {
        get {
            if (packageSettings == null) {
                packageSettings = Settings__c.getInstance();
            }
            return packageSettings;
        }
        private set;
    }

    public static Boolean isCpqEnabled() {
        return packageSettings.CpqEnabled__c;
    }

    public static String getQliToSapFieldMappingPlugin() {
        return String.isBlank(packageSettings.QliToSapFieldMappingPlugin__c)
            ? 'QuoteLineToSalesAgreementProductMapping'
            : packageSettings.QliToSapFieldMappingPlugin__c;
    }

    public static String getQuoteLineAccountField() {
        return String.isBlank(packageSettings.QuoteLineAccountField__c)
            ? 'AccountId__c'
            : packageSettings.QuoteLineAccountField__c;
    }

    public static String getSalesAgreementQuoteField() {
        return String.isBlank(packageSettings.SalesAgreementQuoteField__c)
            ? 'Quote__c'
            : packageSettings.SalesAgreementQuoteField__c;
    }

    public static Boolean isMatchQliAccountToSaAccount() {
        return packageSettings.MatchQliAccountToSaAccount__c;
    }
}

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

    public static String getSaAccountFieldApiName() {
        return String.isBlank(packageSettings.SaAccountFieldApiName__c) == null
            ? 'AccountId'
            : packageSettings.SaAccountFieldApiName__c;
    }
}

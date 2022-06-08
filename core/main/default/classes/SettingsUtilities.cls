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
}

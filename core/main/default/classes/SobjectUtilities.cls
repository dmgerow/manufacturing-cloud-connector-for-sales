@namespaceAccessible
public with sharing class SobjectUtilities {
    @namespaceAccessible
    public static Map<String, Schema.SObjectField> getFieldMap(SObjectType sobjType) {
        return sobjType.getDescribe().fields.getMap();
    }
}

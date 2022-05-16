public with sharing class SobjectUtilities {
    public static Map<String, Schema.SObjectField> getFieldMap(SObjectType sobjType) {
        return sobjType.getDescribe().fields.getMap();
    }
}

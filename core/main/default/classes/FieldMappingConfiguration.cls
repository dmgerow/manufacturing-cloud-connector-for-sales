@SuppressWarnings('PMD.AvoidGlobalModifier')
global interface FieldMappingConfiguration {
    // Field mappings based on API name.
    // Key is source field API name, value is target field API Name.
    Map<String, String> sourceToTargetMapping();

    // When a record is merged, which fields should have their values summed
    Set<String> fieldsToSumOnMerge();

    // When a record is merged, which fields should have their values set based on a weighted
    // average based on quantity.
    Set<String> fieldsToWeightedAverageOnMerge();
}

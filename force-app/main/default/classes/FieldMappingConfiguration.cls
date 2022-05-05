public interface FieldMappingConfiguration {
    Map<String, String> sourceToTargetMapping();
    Set<String> fieldsToSumOnMerge();
    Set<String> fieldsToWeightedAverageOnMerge();
}

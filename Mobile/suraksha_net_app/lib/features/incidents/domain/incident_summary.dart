class IncidentSummary {
  const IncidentSummary({
    required this.id,
    required this.categoryLabel,
    required this.approximateArea,
    required this.status,
    required this.lastUpdatedLabel,
    required this.isSensitive,
  });

  final String id;
  final String categoryLabel;
  final String approximateArea;
  final String status;
  final String lastUpdatedLabel;
  final bool isSensitive;
}

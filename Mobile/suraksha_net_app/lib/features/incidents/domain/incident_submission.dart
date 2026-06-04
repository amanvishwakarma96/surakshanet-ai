class IncidentSubmission {
  const IncidentSubmission({
    required this.categoryId,
    required this.categoryLabel,
    required this.approximateArea,
    required this.description,
    required this.isSensitive,
  });

  final String categoryId;
  final String categoryLabel;
  final String approximateArea;
  final String description;
  final bool isSensitive;
}

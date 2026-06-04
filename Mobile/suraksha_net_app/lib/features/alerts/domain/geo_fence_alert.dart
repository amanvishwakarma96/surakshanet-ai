class GeoFenceAlert {
  const GeoFenceAlert({
    required this.id,
    required this.title,
    required this.message,
    required this.severity,
    required this.hazardType,
    required this.approximateAreaName,
    required this.radiusLabel,
    required this.safetyAction,
    required this.publishedLabel,
    required this.privacyNote,
    this.distanceLabel,
  });

  final String id;
  final String title;
  final String message;
  final String severity;
  final String hazardType;
  final String approximateAreaName;
  final String radiusLabel;
  final String safetyAction;
  final String publishedLabel;
  final String privacyNote;
  final String? distanceLabel;
}

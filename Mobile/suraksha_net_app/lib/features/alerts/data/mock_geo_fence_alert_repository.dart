import '../domain/geo_fence_alert.dart';

class MockGeoFenceAlertRepository {
  const MockGeoFenceAlertRepository();

  List<GeoFenceAlert> listNearbyAlerts({required bool useApproximateLocation}) {
    return _alerts
        .map(
          (alert) => useApproximateLocation
              ? alert
              : GeoFenceAlert(
                  id: alert.id,
                  title: alert.title,
                  message: alert.message,
                  severity: alert.severity,
                  hazardType: alert.hazardType,
                  approximateAreaName: alert.approximateAreaName,
                  radiusLabel: alert.radiusLabel,
                  safetyAction: alert.safetyAction,
                  publishedLabel: alert.publishedLabel,
                  privacyNote: alert.privacyNote,
                ),
        )
        .toList(growable: false);
  }

  static const List<GeoFenceAlert> _alerts = [
    GeoFenceAlert(
      id: 'ALERT-MOCK-2001',
      title: 'Flood caution near Ward 1 bus stop',
      message: 'Avoid low-lying routes near the central bus stop. Use alternate roads and follow official guidance.',
      severity: 'High',
      hazardType: 'Flood / waterlogging',
      approximateAreaName: 'Ward 1 central bus stop area',
      radiusLabel: '750m approximate safety radius',
      distanceLabel: 'Approx. 320m from your shared area',
      safetyAction: 'Use the east market road detour and avoid underpass access until officials clear it.',
      publishedLabel: 'Published after human verification',
      privacyNote: 'Reporter identity and exact coordinates are hidden. This alert uses approximate area copy only.',
    ),
    GeoFenceAlert(
      id: 'ALERT-MOCK-2002',
      title: 'Electric hazard reported near Lake Road',
      message: 'Keep distance from a suspected exposed wire zone and report emergencies to local authorities.',
      severity: 'Critical',
      hazardType: 'Electric hazard',
      approximateAreaName: 'Lake Road bus stop surroundings',
      radiusLabel: '500m approximate safety radius',
      distanceLabel: 'Approx. 610m from your shared area',
      safetyAction: 'Do not touch waterlogged poles, barricades, or loose cables. Move away and call emergency services if needed.',
      publishedLabel: 'Published after human verification',
      privacyNote: 'Exact reporter location is not shown; residents receive only geo-fenced safety guidance.',
    ),
  ];
}

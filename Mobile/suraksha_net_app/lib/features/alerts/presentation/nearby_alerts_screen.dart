import 'package:flutter/material.dart';

import '../../../shared/widgets/privacy_notice_card.dart';
import '../data/mock_geo_fence_alert_repository.dart';
import '../domain/geo_fence_alert.dart';

class NearbyAlertsScreen extends StatefulWidget {
  const NearbyAlertsScreen({super.key});

  @override
  State<NearbyAlertsScreen> createState() => _NearbyAlertsScreenState();
}

class _NearbyAlertsScreenState extends State<NearbyAlertsScreen> {
  final MockGeoFenceAlertRepository _repository =
      const MockGeoFenceAlertRepository();
  bool _useApproximateLocation = false;

  @override
  Widget build(BuildContext context) {
    final alerts = _repository.listNearbyAlerts(
      useApproximateLocation: _useApproximateLocation,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Nearby alerts')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              'Geo-fenced safety alerts',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            const Text(
              'Review verified hazards for your approximate area and choose safe next steps without exposing reporter identity.',
            ),
            const SizedBox(height: 20),
            const PrivacyNoticeCard(
              message: 'Alerts describe approximate areas and safety actions. Exact coordinates are never shown without consent.',
            ),
            const SizedBox(height: 12),
            _ApproximateLocationConsentCard(
              useApproximateLocation: _useApproximateLocation,
              onChanged: (value) => setState(() {
                _useApproximateLocation = value;
              }),
            ),
            const SizedBox(height: 12),
            ...alerts.map((alert) => _AlertCard(alert: alert)),
          ],
        ),
      ),
    );
  }
}

class _ApproximateLocationConsentCard extends StatelessWidget {
  const _ApproximateLocationConsentCard({
    required this.useApproximateLocation,
    required this.onChanged,
  });

  final bool useApproximateLocation;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SwitchListTile.adaptive(
        value: useApproximateLocation,
        onChanged: onChanged,
        secondary: Icon(
          Icons.my_location_rounded,
          color: Theme.of(context).colorScheme.primary,
        ),
        title: const Text(
          'Use approximate area for matching',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        subtitle: Text(
          useApproximateLocation
              ? 'Mock matching is using an approximate area, not exact GPS.'
              : 'Turn on to simulate nearby matching while keeping exact GPS private.',
        ),
      ),
    );
  }
}

class _AlertCard extends StatelessWidget {
  const _AlertCard({required this.alert});

  final GeoFenceAlert alert;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.warning_amber_rounded, color: colorScheme.error),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        alert.title,
                        style: const TextStyle(fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 4),
                      Text('${alert.severity} • ${alert.hazardType}'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(alert.message),
            const SizedBox(height: 12),
            _AlertMeta(label: 'Approximate area', value: alert.approximateAreaName),
            _AlertMeta(label: 'Geo-fence', value: alert.radiusLabel),
            if (alert.distanceLabel != null)
              _AlertMeta(label: 'Match', value: alert.distanceLabel!),
            _AlertMeta(label: 'Status', value: alert.publishedLabel),
            const SizedBox(height: 12),
            Text(
              'Suggested action',
              style: TextStyle(
                color: colorScheme.primary,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 4),
            Text(alert.safetyAction),
            const SizedBox(height: 12),
            Text(
              alert.privacyNote,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _AlertMeta extends StatelessWidget {
  const _AlertMeta({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text('$label: $value'),
    );
  }
}

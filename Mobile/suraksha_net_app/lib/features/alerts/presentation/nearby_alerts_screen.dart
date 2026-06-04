import 'package:flutter/material.dart';

import '../../../shared/widgets/privacy_notice_card.dart';

class NearbyAlertsScreen extends StatelessWidget {
  const NearbyAlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nearby alerts')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              'Geo-fenced alerts foundation',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            const Text(
              'Verified critical hazards can appear here after backend alert '
              'endpoints are connected.',
            ),
            const SizedBox(height: 20),
            const PrivacyNoticeCard(
              message: 'Alerts should describe approximate areas and safety '
                  'actions without exposing reporter identity or exact coordinates.',
            ),
            const SizedBox(height: 12),
            Card(
              child: ListTile(
                leading: Icon(
                  Icons.notifications_active_rounded,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: const Text('No live alerts in mock mode'),
                subtitle: const Text(
                  'Mock foundation is ready for future geo-fenced alert integration.',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../app.dart';
import '../../../shared/widgets/privacy_notice_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SurakshaNet AI'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed(AppRoutes.profile),
            icon: const Icon(Icons.account_circle_rounded),
            tooltip: 'Profile',
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              'Civic safety dashboard',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            const Text('Report hazards, watch verified alerts, and protect sensitive details by default.'),
            const SizedBox(height: 20),
            const PrivacyNoticeCard(
              message: 'AI verification is decision support only. Human review is required for sensitive publishing.',
            ),
            const SizedBox(height: 20),
            _HomeAction(
              icon: Icons.add_location_alt_rounded,
              title: 'Report incident',
              subtitle: 'Flood, electric, pothole, road, unsafe-area, or other hazard.',
            ),
            _HomeAction(
              icon: Icons.notifications_active_rounded,
              title: 'Nearby alerts',
              subtitle: 'Geo-fenced alert foundation with approximate area copy.',
            ),
            _HomeAction(
              icon: Icons.fact_check_rounded,
              title: 'My reports',
              subtitle: 'Track verification status and audit-safe updates.',
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeAction extends StatelessWidget {
  const _HomeAction({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right_rounded),
      ),
    );
  }
}

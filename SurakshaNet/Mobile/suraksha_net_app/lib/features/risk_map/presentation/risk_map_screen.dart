import 'package:flutter/material.dart';

import '../../alerts/presentation/alert_details_screen.dart';

class RiskMapScreen extends StatelessWidget {
  const RiskMapScreen({super.key});
  static const route = '/risk-map';

  @override
  Widget build(BuildContext context) {
    final alerts = ['Critical live wire zone • 350m', 'Flooded underpass • 1.2km', 'Open manhole warning • 800m'];
    return Scaffold(
      appBar: AppBar(title: const Text('Risk Map')),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        Container(
          height: 220,
          decoration: BoxDecoration(color: Colors.blueGrey.shade100, borderRadius: BorderRadius.circular(18)),
          child: const Center(child: Text('OpenStreetMap / Google Maps placeholder\nActive geo-fence danger zones appear here', textAlign: TextAlign.center)),
        ),
        const SizedBox(height: 16),
        const Text('Nearby Alerts', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        for (final alert in alerts) Card(child: ListTile(leading: const Icon(Icons.warning_amber, color: Colors.orange), title: Text(alert), subtitle: const Text('Tap for suggested action and safe route placeholder'), onTap: () => Navigator.pushNamed(context, AlertDetailsScreen.route, arguments: alert))),
      ]),
    );
  }
}

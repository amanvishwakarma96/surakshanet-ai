import 'package:flutter/material.dart';

class AlertDetailsScreen extends StatelessWidget {
  const AlertDetailsScreen({super.key});
  static const route = '/alert-details';

  @override
  Widget build(BuildContext context) {
    final title = ModalRoute.of(context)?.settings.arguments as String? ?? 'Critical live wire zone • 350m';
    return Scaffold(
      appBar: AppBar(title: const Text('Alert Details')),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        Card(child: ListTile(leading: const Icon(Icons.crisis_alert, color: Colors.red), title: Text(title), subtitle: const Text('Severity: Critical\nRisk type: Civic hazard\nDistance: approximate only'))),
        const Card(child: Padding(padding: EdgeInsets.all(16), child: Text('Suggested action: avoid the area, do not touch water/metal objects, follow official instructions, and call emergency services if life is at risk.'))),
        const Card(child: Padding(padding: EdgeInsets.all(16), child: Text('Safe route placeholder: route engine will avoid active geo-fences in a future release.'))),
      ]),
    );
  }
}

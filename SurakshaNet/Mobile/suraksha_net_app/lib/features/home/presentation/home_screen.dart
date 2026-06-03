import 'package:flutter/material.dart';

import '../../helper/presentation/help_request_screen.dart';
import '../../incidents/presentation/my_reports_screen.dart';
import '../../incidents/presentation/report_incident_screen.dart';
import '../../profile/presentation/profile_screen.dart';
import '../../risk_map/presentation/risk_map_screen.dart';
import '../../solutions/presentation/solution_suggestion_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const route = '/home';

  static const categories = [
    ('Accident / Emergency', Icons.car_crash, Colors.red),
    ('Flood / Drainage Issue', Icons.water_damage, Colors.blue),
    ('Electric Pole / Live Wire Danger', Icons.electric_bolt, Colors.orange),
    ('Pothole / Road Damage', Icons.add_road, Colors.brown),
    ('Open Manhole', Icons.warning, Colors.deepOrange),
    ('Women Safety / Unsafe Area', Icons.shield, Colors.purple),
    ('Corruption / Bribery', Icons.gavel, Colors.indigo),
    ('I Need Help', Icons.sos, Colors.redAccent),
    ('Suggest a Solution', Icons.lightbulb, Colors.green),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SurakshaNet AI'), actions: [IconButton(onPressed: () => Navigator.pushNamed(context, ProfileScreen.route), icon: const Icon(Icons.person))]),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Report verified civic risk in one tap', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 1.15,
            children: [
              for (final item in categories)
                Card(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      if (item.$1 == 'I Need Help') Navigator.pushNamed(context, HelpRequestScreen.route);
                      else if (item.$1 == 'Suggest a Solution') Navigator.pushNamed(context, SolutionSuggestionScreen.route);
                      else Navigator.pushNamed(context, ReportIncidentScreen.route, arguments: item.$1);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(item.$2, color: item.$3, size: 36), const SizedBox(height: 10), Text(item.$1, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w700))]),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Row(children: [Expanded(child: OutlinedButton.icon(onPressed: () => Navigator.pushNamed(context, MyReportsScreen.route), icon: const Icon(Icons.list), label: const Text('My Reports'))), const SizedBox(width: 12), Expanded(child: OutlinedButton.icon(onPressed: () => Navigator.pushNamed(context, RiskMapScreen.route), icon: const Icon(Icons.map), label: const Text('Risk Map')))]),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/services/app_state.dart';

class MyReportsScreen extends StatelessWidget {
  const MyReportsScreen({super.key});
  static const route = '/reports';
  static const statuses = ['Submitted', 'AI Checked', 'Needs More Evidence', 'Verified', 'Assigned', 'In Progress', 'Resolved With Proof', 'Rejected', 'Duplicate'];

  @override
  Widget build(BuildContext context) {
    final reports = context.watch<AppState>().reports;
    return Scaffold(
      appBar: AppBar(title: const Text('My Reports')),
      body: reports.isEmpty
          ? Center(child: Text('No reports yet. Status flow: ${statuses.join(' → ')}', textAlign: TextAlign.center))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: reports.length,
              itemBuilder: (_, i) {
                final report = reports[i];
                return Card(child: ListTile(leading: const Icon(Icons.report), title: Text(report.title), subtitle: Text('${report.severity} • ${report.status}\n${report.description ?? ''}'), isThreeLine: true, trailing: report.isAnonymous ? const Icon(Icons.visibility_off) : null));
              },
            ),
    );
  }
}

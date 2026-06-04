import 'package:flutter/material.dart';

import '../data/mock_incident_repository.dart';

class MyReportsScreen extends StatelessWidget {
  const MyReportsScreen({
    super.key,
    this.repository = const MockIncidentRepository(),
  });

  final MockIncidentRepository repository;

  @override
  Widget build(BuildContext context) {
    final reports = repository.listMyReports();

    return Scaffold(
      appBar: AppBar(title: const Text('My reports')),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(20),
          itemCount: reports.length + 1,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            if (index == 0) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Verification status',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Mock report cards show privacy-safe summary data only. '
                    'Audit history and details are planned for later tasks.',
                  ),
                ],
              );
            }

            final report = reports[index - 1];
            return Card(
              child: ListTile(
                leading: Icon(
                  report.isSensitive
                      ? Icons.lock_rounded
                      : Icons.fact_check_rounded,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: Text(
                  '${report.id} • ${report.categoryLabel}',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                subtitle: Text(
                  '${report.approximateArea}\n'
                  '${report.status} • ${report.lastUpdatedLabel}',
                ),
                isThreeLine: true,
                trailing: const Icon(Icons.chevron_right_rounded),
              ),
            );
          },
        ),
      ),
    );
  }
}

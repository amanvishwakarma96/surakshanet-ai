import 'package:flutter/material.dart';

import '../../../app.dart';
import '../../../core/constants/incident_categories.dart';
import '../../../shared/widgets/privacy_notice_card.dart';
import '../../../shared/widgets/safety_disclaimer_card.dart';

class ReportIncidentScreen extends StatefulWidget {
  const ReportIncidentScreen({super.key});

  @override
  State<ReportIncidentScreen> createState() => _ReportIncidentScreenState();
}

class _ReportIncidentScreenState extends State<ReportIncidentScreen> {
  String _selectedCategoryId = incidentCategories.first.id;
  bool _markSensitive = false;

  @override
  Widget build(BuildContext context) {
    final selectedCategory = incidentCategories.firstWhere(
      (category) => category.id == _selectedCategoryId,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Report incident')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              'One-tap safety report',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            const Text(
              'Start with a category and approximate area. Media upload, GPS, '
              'and API submission will be added in later scoped tasks.',
            ),
            const SizedBox(height: 20),
            const SafetyDisclaimerCard(),
            const SizedBox(height: 20),
            Text('Category', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            ...incidentCategories.map(
              (category) => _CategoryOption(
                category: category,
                selected: category.id == _selectedCategoryId,
                onTap: () => setState(() => _selectedCategoryId = category.id),
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              minLines: 2,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Approximate area',
                hintText: 'Example: near Ward 12 market, not exact home location',
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              minLines: 3,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'What happened?',
                hintText: 'Describe visible risk without naming private people.',
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: SwitchListTile.adaptive(
                value: _markSensitive,
                onChanged: (value) => setState(() => _markSensitive = value),
                title: const Text('Mark as sensitive'),
                subtitle: const Text(
                  'Sensitive reports require human review before public publishing.',
                ),
              ),
            ),
            const SizedBox(height: 12),
            PrivacyNoticeCard(
              message:
                  'Selected: ${selectedCategory.label}. Exact coordinates and '
                  'reporter identity stay private in this foundation flow.',
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () =>
                  Navigator.of(context).pushReplacementNamed(AppRoutes.myReports),
              icon: const Icon(Icons.save_rounded),
              label: const Text('Save mock report'),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryOption extends StatelessWidget {
  const _CategoryOption({
    required this.category,
    required this.selected,
    required this.onTap,
  });

  final IncidentCategory category;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        leading: Icon(
          category.icon,
          color: Theme.of(context).colorScheme.primary,
        ),
        title: Text(
          category.label,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        subtitle: Text(category.description),
        trailing: selected
            ? Icon(
                Icons.check_circle_rounded,
                color: Theme.of(context).colorScheme.primary,
              )
            : const Icon(Icons.radio_button_unchecked_rounded),
      ),
    );
  }
}

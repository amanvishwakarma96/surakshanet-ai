import 'package:flutter/material.dart';

import '../../../app.dart';
import '../../../core/constants/incident_categories.dart';
import '../../../shared/widgets/privacy_notice_card.dart';
import '../../../shared/widgets/safety_disclaimer_card.dart';
import '../data/mock_incident_repository.dart';
import '../domain/incident_submission.dart';

class ReportIncidentScreen extends StatefulWidget {
  const ReportIncidentScreen({
    super.key,
    this.repository = const MockIncidentRepository(),
  });

  final MockIncidentRepository repository;

  @override
  State<ReportIncidentScreen> createState() => _ReportIncidentScreenState();
}

class _ReportIncidentScreenState extends State<ReportIncidentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _areaController = TextEditingController();
  final _descriptionController = TextEditingController();

  String _selectedCategoryId = incidentCategories.first.id;
  bool _markSensitive = false;
  bool _submitted = false;

  @override
  void dispose() {
    _areaController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedCategory = incidentCategories.firstWhere(
      (category) => category.id == _selectedCategoryId,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Report incident')),
      body: SafeArea(
        child: Form(
          key: _formKey,
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
                'Share a privacy-safe incident summary for AI-assisted triage. '
                'Exact GPS and reporter identity are not included in this MVP flow.',
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
              TextFormField(
                controller: _areaController,
                minLines: 2,
                maxLines: 3,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Approximate area',
                  hintText: 'Example: near Ward 12 market, not exact home location',
                  helperText: 'Use landmarks or a rough area only.',
                ),
                validator: (value) {
                  final trimmed = value?.trim() ?? '';
                  if (trimmed.length < 6) {
                    return 'Enter an approximate area with at least 6 characters.';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                minLines: 3,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'What happened?',
                  hintText: 'Describe visible risk without naming private people.',
                  helperText: 'Avoid names, phone numbers, and exact addresses.',
                ),
                validator: (value) {
                  final trimmed = value?.trim() ?? '';
                  if (trimmed.length < 12) {
                    return 'Describe the incident in at least 12 characters.';
                  }

                  return null;
                },
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
                    'Selected: ${selectedCategory.label}. Only approximate area, '
                    'category, sensitivity, and description are saved in mock mode.',
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _submitted ? null : () => _submit(selectedCategory),
                icon: const Icon(Icons.save_rounded),
                label: const Text('Save mock report'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit(IncidentCategory selectedCategory) {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _submitted = true);

    final incident = widget.repository.submitIncident(
      IncidentSubmission(
        categoryId: selectedCategory.id,
        categoryLabel: selectedCategory.label,
        approximateArea: _areaController.text,
        description: _descriptionController.text,
        isSensitive: _markSensitive,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${incident.id} submitted for verification.')),
    );
    Navigator.of(context).pushReplacementNamed(AppRoutes.myReports);
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

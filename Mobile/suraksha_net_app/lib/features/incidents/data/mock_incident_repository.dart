import '../domain/incident_submission.dart';
import '../domain/incident_summary.dart';

class MockIncidentRepository {
  const MockIncidentRepository();

  static final List<IncidentSummary> _reports = [
    const IncidentSummary(
      id: 'INC-MOCK-1001',
      categoryLabel: 'Flood / waterlogging',
      approximateArea: 'Near Ward 12 community market',
      status: 'Needs human review',
      lastUpdatedLabel: 'Updated today',
      isSensitive: false,
    ),
    const IncidentSummary(
      id: 'INC-MOCK-1002',
      categoryLabel: 'Electric hazard',
      approximateArea: 'Approx. 300m from Lake Road bus stop',
      status: 'AI support score ready',
      lastUpdatedLabel: 'Updated yesterday',
      isSensitive: true,
    ),
  ];

  List<IncidentSummary> listMyReports() {
    return List.unmodifiable(_reports);
  }

  IncidentSummary submitIncident(IncidentSubmission submission) {
    final incident = IncidentSummary(
      id: 'INC-MOCK-${1001 + _reports.length}',
      categoryLabel: submission.categoryLabel,
      approximateArea: submission.approximateArea.trim(),
      status: submission.isSensitive
          ? 'Sensitive: awaiting human review'
          : 'Submitted for AI-assisted review',
      lastUpdatedLabel: 'Updated just now',
      isSensitive: submission.isSensitive,
    );

    _reports.insert(0, incident);
    return incident;
  }

  static void resetForTesting() {
    _reports
      ..clear()
      ..addAll([
        const IncidentSummary(
          id: 'INC-MOCK-1001',
          categoryLabel: 'Flood / waterlogging',
          approximateArea: 'Near Ward 12 community market',
          status: 'Needs human review',
          lastUpdatedLabel: 'Updated today',
          isSensitive: false,
        ),
        const IncidentSummary(
          id: 'INC-MOCK-1002',
          categoryLabel: 'Electric hazard',
          approximateArea: 'Approx. 300m from Lake Road bus stop',
          status: 'AI support score ready',
          lastUpdatedLabel: 'Updated yesterday',
          isSensitive: true,
        ),
      ]);
  }
}

import '../domain/incident_summary.dart';

class MockIncidentRepository {
  const MockIncidentRepository();

  List<IncidentSummary> listMyReports() {
    return const [
      IncidentSummary(
        id: 'INC-MOCK-1001',
        categoryLabel: 'Flood / waterlogging',
        approximateArea: 'Near Ward 12 community market',
        status: 'Needs human review',
        lastUpdatedLabel: 'Updated today',
        isSensitive: false,
      ),
      IncidentSummary(
        id: 'INC-MOCK-1002',
        categoryLabel: 'Electric hazard',
        approximateArea: 'Approx. 300m from Lake Road bus stop',
        status: 'AI support score ready',
        lastUpdatedLabel: 'Updated yesterday',
        isSensitive: true,
      ),
    ];
  }
}

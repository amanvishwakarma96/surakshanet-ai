import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suraksha_net_app/app.dart';
import 'package:suraksha_net_app/features/incidents/data/mock_incident_repository.dart';

void main() {
  setUp(MockIncidentRepository.resetForTesting);

  testWidgets('shows splash screen title and privacy message', (tester) async {
    await tester.pumpWidget(const SurakshaNetApp());

    expect(find.text('SurakshaNet AI'), findsOneWidget);
    expect(
      find.text('Verification-first civic safety alerts with privacy by default.'),
      findsOneWidget,
    );
  });

  testWidgets(
    'navigates to dashboard and report incident foundation',
    (tester) async {
      await tester.pumpWidget(const SurakshaNetApp());

      await tester.tap(find.text('Get started'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Enter mock app'));
      await tester.pumpAndSettle();

      expect(find.text('Civic safety dashboard'), findsOneWidget);

      await tester.tap(find.text('Report incident'));
      await tester.pumpAndSettle();

      expect(find.text('One-tap safety report'), findsOneWidget);
      expect(find.text('Flood / waterlogging'), findsOneWidget);
      expect(find.text('Save mock report'), findsOneWidget);
    },
  );

  testWidgets(
    'saves a privacy-safe incident report and shows it in my reports',
    (tester) async {
      await tester.pumpWidget(const SurakshaNetApp());

      await tester.tap(find.text('Get started'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Enter mock app'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Report incident'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Pothole / road damage'));
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Approximate area'),
        'Near Central Park north gate',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'What happened?'),
        'Large pothole blocking the left lane after rain.',
      );
      await tester.ensureVisible(find.text('Save mock report'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Save mock report'));
      await tester.pumpAndSettle();

      expect(find.text('Verification status'), findsOneWidget);
      expect(find.textContaining('INC-MOCK-1003'), findsOneWidget);
      expect(find.textContaining('Pothole / road damage'), findsOneWidget);
      expect(find.textContaining('Near Central Park north gate'), findsOneWidget);
      expect(
        find.textContaining('Submitted for AI-assisted review'),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'validates approximate area and description before saving',
    (tester) async {
      await tester.pumpWidget(const SurakshaNetApp());

      await tester.tap(find.text('Get started'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Enter mock app'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Report incident'));
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.text('Save mock report'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Save mock report'));
      await tester.pumpAndSettle();

      expect(
        find.text('Enter an approximate area with at least 6 characters.'),
        findsOneWidget,
      );
      expect(
        find.text('Describe the incident in at least 12 characters.'),
        findsOneWidget,
      );
      expect(find.text('One-tap safety report'), findsOneWidget);
    },
  );

  testWidgets(
    'home actions open mock alert and report history screens',
    (tester) async {
      await tester.pumpWidget(const SurakshaNetApp());

      await tester.tap(find.text('Get started'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Enter mock app'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Nearby alerts'));
      await tester.pumpAndSettle();

      expect(find.text('Geo-fenced safety alerts'), findsOneWidget);
      expect(find.text('Use approximate area for matching'), findsOneWidget);
      expect(find.text('Flood caution near Ward 1 bus stop'), findsOneWidget);

      await tester.pageBack();
      await tester.pumpAndSettle();
      await tester.tap(find.text('My reports'));
      await tester.pumpAndSettle();

      expect(find.text('Verification status'), findsOneWidget);
      expect(find.textContaining('INC-MOCK-1001'), findsOneWidget);
      expect(find.textContaining('Flood / waterlogging'), findsOneWidget);
    },
  );
  testWidgets(
    'nearby alerts can simulate approximate geo-fence matching',
    (tester) async {
      await tester.pumpWidget(const SurakshaNetApp());

      await tester.tap(find.text('Get started'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Enter mock app'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Nearby alerts'));
      await tester.pumpAndSettle();

      expect(find.text('Approx. 320m from your shared area'), findsNothing);

      await tester.tap(find.byType(SwitchListTile).first);
      await tester.pumpAndSettle();

      expect(
        find.text('Mock matching is using an approximate area, not exact GPS.'),
        findsOneWidget,
      );
      expect(find.text('Approx. 320m from your shared area'), findsOneWidget);
      expect(find.text('Published after human verification'), findsWidgets);
    },
  );

}

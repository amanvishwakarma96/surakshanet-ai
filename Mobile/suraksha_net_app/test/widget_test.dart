import 'package:flutter_test/flutter_test.dart';
import 'package:suraksha_net_app/app.dart';

void main() {
  testWidgets('shows splash screen title and privacy message', (tester) async {
    await tester.pumpWidget(const SurakshaNetApp());

    expect(find.text('SurakshaNet AI'), findsOneWidget);
    expect(
      find.text('Verification-first civic safety alerts with privacy by default.'),
      findsOneWidget,
    );
  });

  testWidgets('navigates to dashboard and report incident foundation', (tester) async {
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
  });

  testWidgets('home actions open mock alert and report history screens', (tester) async {
    await tester.pumpWidget(const SurakshaNetApp());

    await tester.tap(find.text('Get started'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Enter mock app'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Nearby alerts'));
    await tester.pumpAndSettle();

    expect(find.text('Geo-fenced alerts foundation'), findsOneWidget);
    expect(find.text('No live alerts in mock mode'), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.tap(find.text('My reports'));
    await tester.pumpAndSettle();

    expect(find.text('Verification status'), findsOneWidget);
    expect(find.textContaining('INC-MOCK-1001'), findsOneWidget);
    expect(find.textContaining('Flood / waterlogging'), findsOneWidget);
  });
}

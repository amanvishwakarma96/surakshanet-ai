import 'package:flutter_test/flutter_test.dart';
import 'package:suraksha_net_app/app.dart';

void main() {
  testWidgets('shows splash screen title and privacy message', (tester) async {
    await tester.pumpWidget(const SurakshaNetApp());

    expect(find.text('SurakshaNet AI'), findsOneWidget);
    expect(find.text('Verification-first civic safety alerts with privacy by default.'), findsOneWidget);
  });
}

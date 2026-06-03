import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'features/alerts/presentation/alert_details_screen.dart';
import 'features/auth/presentation/login_register_screen.dart';
import 'features/auth/presentation/splash_screen.dart';
import 'features/helper/presentation/help_request_screen.dart';
import 'features/home/presentation/home_screen.dart';
import 'features/incidents/presentation/my_reports_screen.dart';
import 'features/incidents/presentation/report_incident_screen.dart';
import 'features/profile/presentation/profile_screen.dart';
import 'features/risk_map/presentation/risk_map_screen.dart';
import 'features/solutions/presentation/solution_suggestion_screen.dart';
import 'shared/services/app_state.dart';

class SurakshaNetApp extends StatelessWidget {
  const SurakshaNetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SurakshaNet AI',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: Consumer<AppState>(
        builder: (_, state, __) {
          if (!state.isReady) return const SplashScreen();
          return state.isLoggedIn ? const HomeScreen() : const LoginRegisterScreen();
        },
      ),
      routes: {
        HomeScreen.route: (_) => const HomeScreen(),
        LoginRegisterScreen.route: (_) => const LoginRegisterScreen(),
        MyReportsScreen.route: (_) => const MyReportsScreen(),
        RiskMapScreen.route: (_) => const RiskMapScreen(),
        HelpRequestScreen.route: (_) => const HelpRequestScreen(),
        SolutionSuggestionScreen.route: (_) => const SolutionSuggestionScreen(),
        ProfileScreen.route: (_) => const ProfileScreen(),
        AlertDetailsScreen.route: (_) => const AlertDetailsScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == ReportIncidentScreen.route) {
          final category = settings.arguments as String? ?? 'Accident / Emergency';
          return MaterialPageRoute(builder: (_) => ReportIncidentScreen(category: category));
        }
        return null;
      },
    );
  }
}

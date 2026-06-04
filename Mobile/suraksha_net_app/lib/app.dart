import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/alerts/presentation/nearby_alerts_screen.dart';
import 'features/auth/presentation/login_register_screen.dart';
import 'features/home/presentation/home_screen.dart';
import 'features/incidents/presentation/my_reports_screen.dart';
import 'features/incidents/presentation/report_incident_screen.dart';
import 'features/profile/presentation/profile_screen.dart';
import 'features/splash/presentation/splash_screen.dart';

class AppRoutes {
  static const splash = '/';
  static const loginRegister = '/login-register';
  static const home = '/home';
  static const reportIncident = '/report-incident';
  static const myReports = '/my-reports';
  static const nearbyAlerts = '/nearby-alerts';
  static const profile = '/profile';
}

class SurakshaNetApp extends StatelessWidget {
  const SurakshaNetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SurakshaNet AI',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: AppRoutes.splash,
      routes: {
        AppRoutes.splash: (_) => const SplashScreen(),
        AppRoutes.loginRegister: (_) => const LoginRegisterScreen(),
        AppRoutes.home: (_) => const HomeScreen(),
        AppRoutes.reportIncident: (_) => const ReportIncidentScreen(),
        AppRoutes.myReports: (_) => const MyReportsScreen(),
        AppRoutes.nearbyAlerts: (_) => const NearbyAlertsScreen(),
        AppRoutes.profile: (_) => const ProfileScreen(),
      },
    );
  }
}

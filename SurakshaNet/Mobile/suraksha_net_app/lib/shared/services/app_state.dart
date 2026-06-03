import 'package:flutter/foundation.dart';

import '../models/incident.dart';

class AppState extends ChangeNotifier {
  bool isReady = false;
  bool isLoggedIn = false;
  String token = '';
  final List<Incident> reports = [];

  Future<void> bootstrap() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    isReady = true;
    notifyListeners();
  }

  Future<void> loginOrRegister({required String email, required String password, required bool register}) async {
    // MVP mock-mode fallback. The API service can replace this without changing UI flows.
    token = 'mock-jwt-token';
    isLoggedIn = true;
    notifyListeners();
  }

  Future<Incident> submitIncident({required String category, required String description, required bool anonymous}) async {
    final critical = category.contains('Electric') || description.toLowerCase().contains('live wire') || description.toLowerCase().contains('trapped');
    final incident = Incident(
      id: reports.length + 1,
      category: category,
      title: category,
      description: description,
      status: critical ? 'AI Checked' : 'Submitted',
      severity: critical ? 'Critical' : (category.contains('Pothole') ? 'Medium' : 'High'),
      isAnonymous: anonymous,
    );
    reports.insert(0, incident);
    notifyListeners();
    return incident;
  }

  void logout() {
    token = '';
    isLoggedIn = false;
    notifyListeners();
  }
}

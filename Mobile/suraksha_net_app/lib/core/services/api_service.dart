import '../config/app_config.dart';

class ApiService {
  const ApiService({this.config = AppConfig.localMock});

  final AppConfig config;

  Future<String> healthCheck() async {
    if (config.mockMode) {
      return 'mock-api-ready';
    }

    throw UnimplementedError(
      'Backend API integration for ${config.apiBaseUrl} will be added in a later scoped task.',
    );
  }
}

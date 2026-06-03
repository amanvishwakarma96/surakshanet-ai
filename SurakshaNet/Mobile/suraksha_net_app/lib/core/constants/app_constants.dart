class AppConstants {
  static const apiBaseUrl = String.fromEnvironment('API_BASE_URL', defaultValue: 'http://localhost:5000/api');
  static const mockModeFallback = true;
  static const sensitiveCategories = ['Women Safety / Unsafe Area', 'Corruption / Bribery', 'I Need Help'];
}

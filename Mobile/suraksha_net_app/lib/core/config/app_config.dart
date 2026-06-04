class AppConfig {
  const AppConfig({
    this.mockMode = true,
    this.apiBaseUrl = 'http://localhost:5088',
  });

  final bool mockMode;
  final String apiBaseUrl;

  static const localMock = AppConfig();
}

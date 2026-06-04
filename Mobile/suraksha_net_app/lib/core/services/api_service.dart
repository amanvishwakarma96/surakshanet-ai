class ApiService {
  const ApiService({this.mockMode = true});

  final bool mockMode;

  Future<String> healthCheck() async {
    if (mockMode) {
      return 'mock-api-ready';
    }

    throw UnimplementedError(
      'Backend API integration will be added in a later scoped task.',
    );
  }
}

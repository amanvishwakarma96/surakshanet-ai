class PrivacyRules {
  static String publicReporterLabel({required bool isAnonymous, required bool sensitive}) {
    if (isAnonymous || sensitive) return 'Identity Protected';
    return 'Verified Citizen';
  }

  static String publicLocationText({required bool sensitive, required String locationText}) {
    // Exact location is not shown publicly for sensitive categories; backend enforces this too.
    return sensitive ? 'Approximate area only' : locationText;
  }
}

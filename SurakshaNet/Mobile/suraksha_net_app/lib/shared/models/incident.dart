class Incident {
  Incident({required this.id, required this.category, required this.title, required this.status, required this.severity, this.description, this.isAnonymous = true});

  final int id;
  final String category;
  final String title;
  final String status;
  final String severity;
  final String? description;
  final bool isAnonymous;
}

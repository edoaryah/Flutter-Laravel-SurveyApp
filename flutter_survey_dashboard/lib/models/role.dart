class RoleReport {
  final String role;
  final int count;

  RoleReport({required this.role, required this.count});

  factory RoleReport.fromJson(Map<String, dynamic> parsedJson) {
    return RoleReport(
      role: parsedJson['Role'] as String,
      count: parsedJson['count'] as int,
    );
  }
}

class ReportDetails {
  final int id;
  final String name;
  final int age;
  final String gender;
  final String role;
  final String type;
  final String reports;

  ReportDetails({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.role,
    required this.type,
    required this.reports,
  });

  factory ReportDetails.fromJson(Map<String, dynamic> parsedJson) {
    return ReportDetails(
      id: parsedJson['id'] as int,
      name: parsedJson['Name'] as String,
      age: parsedJson['Age'] as int,
      gender: parsedJson['Gender'] as String,
      role: parsedJson['Role'] as String,
      type: parsedJson['Type'] as String,
      reports: parsedJson['Reports'] as String,
    );
  }
}

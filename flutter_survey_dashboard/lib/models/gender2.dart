class GenderReport {
  final String gender;
  final int count;

  GenderReport({required this.gender, required this.count});

  factory GenderReport.fromJson(Map<String, dynamic> parsedJson) {
    return GenderReport(
      gender: parsedJson['Gender'] as String,
      count: parsedJson['count'] as int,
    );
  }
}

class TypeReport {
  final String type;
  final int count;

  TypeReport({required this.type, required this.count});

  factory TypeReport.fromJson(Map<String, dynamic> parsedJson) {
    return TypeReport(
      type: parsedJson['Type'] as String,
      count: parsedJson['count'] as int,
    );
  }
}

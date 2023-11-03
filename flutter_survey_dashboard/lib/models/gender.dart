class GenderRespondents {
  final String gender;
  final int count;

  GenderRespondents({required this.gender, required this.count});

  factory GenderRespondents.fromJson(Map<String, dynamic> parsedJson) {
    return GenderRespondents(
      gender: parsedJson['Gender'] as String,
      count: parsedJson['count'] as int,
    );
  }
}

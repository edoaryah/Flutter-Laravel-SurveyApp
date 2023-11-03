class NationalityRespondents {
  final String nationality;
  final int count;

  NationalityRespondents({required this.nationality, required this.count});

  factory NationalityRespondents.fromJson(Map<String, dynamic> parsedJson) {
    return NationalityRespondents(
      nationality: parsedJson['Nationality'] as String,
      count: parsedJson['count'] as int,
    );
  }
}

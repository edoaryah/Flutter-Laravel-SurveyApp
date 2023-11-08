class SurveyDetails {
  final int id;
  final String genre;
  final String reports;
  final int age;
  final String gpa;
  final int year;
  final String gender;
  final String nationality;

  SurveyDetails({
    required this.id,
    required this.genre,
    required this.reports,
    required this.age,
    required this.gpa,
    required this.year,
    required this.gender,
    required this.nationality,
  });

  factory SurveyDetails.fromJson(Map<String, dynamic> parsedJson) {
    return SurveyDetails(
      id: parsedJson['id'] as int,
      genre: parsedJson['Genre'] as String,
      reports: parsedJson['Reports'] as String,
      age: parsedJson['Age'] as int,
      gpa: parsedJson['Gpa'] as String,
      year: parsedJson['Year'] as int,
      gender: parsedJson['Gender'] as String,
      nationality: parsedJson['Nationality'] as String,
    );
  }

  SurveyDetails copyWith({
    int? id,
    String? genre,
    String? reports,
    int? age,
    String? gpa,
    int? year,
    String? gender,
    String? nationality,
  }) {
    return SurveyDetails(
      id: id ?? this.id,
      genre: genre ?? this.genre,
      reports: reports ?? this.reports,
      age: age ?? this.age,
      gpa: gpa ?? this.gpa,
      year: year ?? this.year,
      gender: gender ?? this.gender,
      nationality: nationality ?? this.nationality,
    );
  }
}

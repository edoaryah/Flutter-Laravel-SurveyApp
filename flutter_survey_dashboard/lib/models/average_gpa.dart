class AverageGpaRespondents {
  final double gpa;

  AverageGpaRespondents({required this.gpa});

  factory AverageGpaRespondents.fromJson(double gpa) {
    return AverageGpaRespondents(
      gpa: gpa,
    );
  }
}

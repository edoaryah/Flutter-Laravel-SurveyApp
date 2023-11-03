class AverageAgeRespondents {
  final double age;

  AverageAgeRespondents({required this.age});

  factory AverageAgeRespondents.fromJson(double age) {
    return AverageAgeRespondents(
      age: age,
    );
  }
}

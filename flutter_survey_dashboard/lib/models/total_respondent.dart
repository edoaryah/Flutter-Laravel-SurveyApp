class TotalRespondents {
  final int total;

  TotalRespondents({required this.total});

  factory TotalRespondents.fromJson(int total) {
    return TotalRespondents(
      total: total,
    );
  }
}

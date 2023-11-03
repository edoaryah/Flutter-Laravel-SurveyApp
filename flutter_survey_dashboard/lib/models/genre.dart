class GenreRespondents {
  final String genre;
  final int count;

  GenreRespondents({required this.genre, required this.count});

  factory GenreRespondents.fromJson(Map<String, dynamic> parsedJson) {
    return GenreRespondents(
      genre: parsedJson['Genre'] as String,
      count: parsedJson['count'] as int,
    );
  }
}

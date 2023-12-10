class KelulusanMahasiswa {
  final String tahunlulus;
  final int count;

  KelulusanMahasiswa({required this.tahunlulus, required this.count});

  factory KelulusanMahasiswa.fromJson(Map<String, dynamic> parsedJson) {
    return KelulusanMahasiswa(
      tahunlulus: parsedJson['Tahun_Lulus'] as String,
      count: parsedJson['count'] as int,
    );
  }
}

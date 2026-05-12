enum SurahType {
  meccan,
  medinan;

  String get label => this == SurahType.meccan ? 'Meccan' : 'Medinan';
}

class Surah {
  final int number;
  final String name;
  final String meaning;
  final String arabicName;
  final int verseCount;
  final SurahType type;
  final int startPage;

  const Surah({
    required this.number,
    required this.name,
    required this.meaning,
    required this.arabicName,
    required this.verseCount,
    required this.type,
    required this.startPage,
  });
}

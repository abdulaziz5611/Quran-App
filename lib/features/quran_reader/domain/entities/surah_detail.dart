import 'package:equatable/equatable.dart';

import 'package:quran_app/features/quran_reader/domain/entities/verse.dart';

class SurahDetail extends Equatable {
  final int number;
  final String nameArabic;
  final String nameEnglish;
  final String nameTranslation;
  final int versesCount;
  final bool bismillahPre;
  final List<Verse> verses;

  const SurahDetail({
    required this.number,
    required this.nameArabic,
    required this.nameEnglish,
    required this.nameTranslation,
    required this.versesCount,
    required this.bismillahPre,
    required this.verses,
  });

  @override
  List<Object?> get props => [
        number,
        nameArabic,
        nameEnglish,
        nameTranslation,
        versesCount,
        bismillahPre,
        verses,
      ];
}

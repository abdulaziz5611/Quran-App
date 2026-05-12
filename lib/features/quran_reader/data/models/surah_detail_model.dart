import 'package:quran_app/features/quran_reader/data/models/verse_model.dart';
import 'package:quran_app/features/quran_reader/domain/entities/surah_detail.dart';

class SurahDetailModel extends SurahDetail {
  const SurahDetailModel({
    required super.number,
    required super.nameArabic,
    required super.nameEnglish,
    required super.nameTranslation,
    required super.versesCount,
    required super.bismillahPre,
    required super.verses,
  });

  factory SurahDetailModel.fromJson(Map<String, dynamic> json) {
    final surahJson = json['surah'] as Map<String, dynamic>;
    final versesJson = (json['verses'] as List?) ?? const [];

    return SurahDetailModel(
      number: (surahJson['number'] as num).toInt(),
      nameArabic: surahJson['name_arabic'] as String? ?? '',
      nameEnglish: surahJson['name_english'] as String? ?? '',
      nameTranslation: surahJson['name_translation'] as String? ?? '',
      versesCount: (surahJson['verses_count'] as num?)?.toInt() ?? 0,
      bismillahPre: surahJson['bismillah_pre'] as bool? ?? false,
      verses: versesJson
          .map((v) => VerseModel.fromJson(v as Map<String, dynamic>))
          .toList(),
    );
  }
}

import 'package:quran_app/features/quran_reader/domain/entities/verse.dart';

class VerseModel extends Verse {
  const VerseModel({
    required super.ayah,
    required super.arabic,
    required super.transliteration,
    required super.translation,
  });

  factory VerseModel.fromJson(Map<String, dynamic> json) {
    final translations = json['translations'] as Map<String, dynamic>? ?? const {};
    return VerseModel(
      ayah: (json['ayah'] as num).toInt(),
      arabic: json['arabic'] as String? ?? '',
      transliteration: json['transliteration'] as String? ?? '',
      translation: (translations['sahih_international'] as String?) ?? '',
    );
  }
}

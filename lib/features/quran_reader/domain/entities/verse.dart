import 'package:equatable/equatable.dart';

class Verse extends Equatable {
  final int ayah;
  final String arabic;
  final String transliteration;
  final String translation;

  const Verse({
    required this.ayah,
    required this.arabic,
    required this.transliteration,
    required this.translation,
  });

  @override
  List<Object?> get props => [ayah, arabic, transliteration, translation];
}

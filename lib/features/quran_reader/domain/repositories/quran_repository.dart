import 'package:dartz/dartz.dart';

import 'package:quran_app/core/error/failures.dart';
import 'package:quran_app/features/quran_reader/domain/entities/surah_detail.dart';

abstract class QuranRepository {
  Future<Either<Failure, SurahDetail>> getSurahDetail(int surahNumber);
}

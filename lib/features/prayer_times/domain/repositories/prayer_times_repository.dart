import 'package:dartz/dartz.dart';

import 'package:quran_app/core/error/failures.dart';
import 'package:quran_app/features/prayer_times/domain/entities/prayer_times.dart';

abstract class PrayerTimesRepository {
  Future<Either<Failure, PrayerTimes>> getTodayPrayerTimes();
}

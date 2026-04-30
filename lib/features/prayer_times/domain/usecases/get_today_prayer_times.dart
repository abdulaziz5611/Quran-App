import 'package:dartz/dartz.dart';

import 'package:quran_app/core/error/failures.dart';
import 'package:quran_app/core/usecase/usecase.dart';
import 'package:quran_app/features/prayer_times/domain/entities/prayer_times.dart';
import 'package:quran_app/features/prayer_times/domain/repositories/prayer_times_repository.dart';

class GetTodayPrayerTimes implements UseCase<PrayerTimes, NoParams> {
  final PrayerTimesRepository repository;

  const GetTodayPrayerTimes(this.repository);

  @override
  Future<Either<Failure, PrayerTimes>> call(NoParams params) {
    return repository.getTodayPrayerTimes();
  }
}

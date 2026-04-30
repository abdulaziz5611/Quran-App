import 'package:dartz/dartz.dart';

import 'package:quran_app/core/error/exceptions.dart';
import 'package:quran_app/core/error/failures.dart';
import 'package:quran_app/features/location/domain/repositories/location_repository.dart';
import 'package:quran_app/features/prayer_times/data/datasources/prayer_times_local_data_source.dart';
import 'package:quran_app/features/prayer_times/domain/entities/prayer_times.dart';
import 'package:quran_app/features/prayer_times/domain/repositories/prayer_times_repository.dart';

class PrayerTimesRepositoryImpl implements PrayerTimesRepository {
  final LocationRepository locationRepository;
  final PrayerTimesLocalDataSource prayerTimesDataSource;

  const PrayerTimesRepositoryImpl({
    required this.locationRepository,
    required this.prayerTimesDataSource,
  });

  @override
  Future<Either<Failure, PrayerTimes>> getTodayPrayerTimes() async {
    final coordsResult = await locationRepository.getCurrentCoordinates();
    return coordsResult.fold(
      Left.new,
      (coords) async {
        try {
          final times = await prayerTimesDataSource.calculateForToday(coords);
          return Right(times);
        } on CalculationException catch (e) {
          return Left(CalculationFailure(e.message));
        }
      },
    );
  }
}

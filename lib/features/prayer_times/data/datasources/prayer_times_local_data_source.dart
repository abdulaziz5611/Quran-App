import 'package:adhan/adhan.dart' as adhan;

import 'package:quran_app/core/error/exceptions.dart';
import 'package:quran_app/features/location/domain/entities/coordinates.dart';
import 'package:quran_app/features/prayer_times/data/models/prayer_times_model.dart';

abstract class PrayerTimesLocalDataSource {
  Future<PrayerTimesModel> calculateForToday(Coordinates coordinates);
}

class PrayerTimesLocalDataSourceImpl implements PrayerTimesLocalDataSource {
  @override
  Future<PrayerTimesModel> calculateForToday(Coordinates coordinates) async {
    try {
      final params = adhan.CalculationMethod.muslim_world_league.getParameters()
        ..madhab = adhan.Madhab.shafi;
      final times = adhan.PrayerTimes.today(
        adhan.Coordinates(coordinates.latitude, coordinates.longitude),
        params,
      );
      return PrayerTimesModel.fromAdhan(times);
    } catch (e) {
      throw CalculationException(e.toString());
    }
  }
}

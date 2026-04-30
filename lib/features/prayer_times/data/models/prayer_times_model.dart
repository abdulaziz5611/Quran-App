import 'package:adhan/adhan.dart' as adhan;

import 'package:quran_app/features/prayer_times/domain/entities/prayer_times.dart';

class PrayerTimesModel extends PrayerTimes {
  const PrayerTimesModel({
    required super.fajr,
    required super.sunrise,
    required super.dhuhr,
    required super.asr,
    required super.maghrib,
    required super.isha,
  });

  factory PrayerTimesModel.fromAdhan(adhan.PrayerTimes times) {
    return PrayerTimesModel(
      fajr: times.fajr,
      sunrise: times.sunrise,
      dhuhr: times.dhuhr,
      asr: times.asr,
      maghrib: times.maghrib,
      isha: times.isha,
    );
  }
}

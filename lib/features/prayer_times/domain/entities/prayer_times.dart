import 'package:equatable/equatable.dart';

import 'prayer.dart';

class PrayerTimes extends Equatable {
  final DateTime fajr;
  final DateTime sunrise;
  final DateTime dhuhr;
  final DateTime asr;
  final DateTime maghrib;
  final DateTime isha;

  const PrayerTimes({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
  });

  List<Prayer> get all => [
        Prayer(name: PrayerName.fajr, time: fajr),
        Prayer(name: PrayerName.sunrise, time: sunrise),
        Prayer(name: PrayerName.dhuhr, time: dhuhr),
        Prayer(name: PrayerName.asr, time: asr),
        Prayer(name: PrayerName.maghrib, time: maghrib),
        Prayer(name: PrayerName.isha, time: isha),
      ];

  Prayer nextPrayer(DateTime now) {
    for (final prayer in all) {
      if (prayer.time.isAfter(now)) return prayer;
    }
    // After Isha — next prayer is tomorrow's Fajr (caller may refresh)
    return Prayer(
      name: PrayerName.fajr,
      time: fajr.add(const Duration(days: 1)),
    );
  }

  /// The most recent prayer whose time has passed, or `null` before Fajr.
  Prayer? currentPrayer(DateTime now) {
    Prayer? current;
    for (final prayer in all) {
      if (prayer.time.isBefore(now) || prayer.time.isAtSameMomentAs(now)) {
        current = prayer;
      } else {
        break;
      }
    }
    return current;
  }

  @override
  List<Object?> get props => [fajr, sunrise, dhuhr, asr, maghrib, isha];
}

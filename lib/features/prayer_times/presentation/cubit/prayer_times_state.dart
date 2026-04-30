part of 'prayer_times_cubit.dart';

abstract class PrayerTimesState extends Equatable {
  const PrayerTimesState();

  @override
  List<Object?> get props => [];
}

class PrayerTimesInitial extends PrayerTimesState {
  const PrayerTimesInitial();
}

class PrayerTimesLoading extends PrayerTimesState {
  const PrayerTimesLoading();
}

class PrayerTimesLoaded extends PrayerTimesState {
  final PrayerTimes prayerTimes;
  final Prayer nextPrayer;

  const PrayerTimesLoaded({
    required this.prayerTimes,
    required this.nextPrayer,
  });

  @override
  List<Object?> get props => [prayerTimes, nextPrayer];
}

class PrayerTimesError extends PrayerTimesState {
  final String message;

  const PrayerTimesError(this.message);

  @override
  List<Object?> get props => [message];
}

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:quran_app/core/usecase/usecase.dart';
import 'package:quran_app/features/prayer_times/domain/entities/prayer.dart';
import 'package:quran_app/features/prayer_times/domain/entities/prayer_times.dart';
import 'package:quran_app/features/prayer_times/domain/usecases/get_today_prayer_times.dart';

part 'prayer_times_state.dart';

class PrayerTimesCubit extends Cubit<PrayerTimesState> {
  final GetTodayPrayerTimes getTodayPrayerTimes;

  PrayerTimesCubit({required this.getTodayPrayerTimes})
      : super(const PrayerTimesInitial());

  Future<void> load() async {
    emit(const PrayerTimesLoading());
    final result = await getTodayPrayerTimes(const NoParams());
    result.fold(
      (failure) => emit(PrayerTimesError(failure.message)),
      (prayerTimes) => emit(
        PrayerTimesLoaded(
          prayerTimes: prayerTimes,
          nextPrayer: prayerTimes.nextPrayer(DateTime.now()),
        ),
      ),
    );
  }
}

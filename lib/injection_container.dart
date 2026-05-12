import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'features/location/data/datasources/location_local_data_source.dart';
import 'features/location/data/repositories/location_repository_impl.dart';
import 'features/location/domain/repositories/location_repository.dart';
import 'features/location/domain/usecases/get_current_coordinates.dart';
import 'features/prayer_times/data/datasources/prayer_times_local_data_source.dart';
import 'features/prayer_times/data/repositories/prayer_times_repository_impl.dart';
import 'features/prayer_times/domain/repositories/prayer_times_repository.dart';
import 'features/prayer_times/domain/usecases/get_today_prayer_times.dart';
import 'features/prayer_times/presentation/cubit/prayer_times_cubit.dart';
import 'features/quran_reader/data/datasources/quran_remote_data_source.dart';
import 'features/quran_reader/data/repositories/quran_repository_impl.dart';
import 'features/quran_reader/domain/repositories/quran_repository.dart';
import 'features/quran_reader/domain/usecases/get_surah_detail.dart';
import 'features/quran_reader/presentation/cubit/quran_reader_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  _initExternal();
  _initLocation();
  _initPrayerTimes();
  _initQuran();
}

void _initExternal() {
  sl.registerLazySingleton<http.Client>(() => http.Client());
}

void _initLocation() {
  sl.registerLazySingleton(() => GetCurrentCoordinates(sl()));

  sl.registerLazySingleton<LocationRepository>(
    () => LocationRepositoryImpl(dataSource: sl()),
  );

  sl.registerLazySingleton<LocationLocalDataSource>(
    () => LocationLocalDataSourceImpl(),
  );
}

void _initPrayerTimes() {
  sl.registerFactory(() => PrayerTimesCubit(getTodayPrayerTimes: sl()));

  sl.registerLazySingleton(() => GetTodayPrayerTimes(sl()));

  sl.registerLazySingleton<PrayerTimesRepository>(
    () => PrayerTimesRepositoryImpl(
      locationRepository: sl(),
      prayerTimesDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<PrayerTimesLocalDataSource>(
    () => PrayerTimesLocalDataSourceImpl(),
  );
}

void _initQuran() {
  sl.registerFactory(() => QuranReaderCubit(getSurahDetail: sl()));

  sl.registerLazySingleton(() => GetSurahDetail(sl()));

  sl.registerLazySingleton<QuranRepository>(
    () => QuranRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton<QuranRemoteDataSource>(
    () => QuranRemoteDataSourceImpl(client: sl()),
  );
}

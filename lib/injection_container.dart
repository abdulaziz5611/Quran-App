import 'package:get_it/get_it.dart';

import 'features/location/data/datasources/location_local_data_source.dart';
import 'features/location/data/repositories/location_repository_impl.dart';
import 'features/location/domain/repositories/location_repository.dart';
import 'features/location/domain/usecases/get_current_coordinates.dart';
import 'features/prayer_times/data/datasources/prayer_times_local_data_source.dart';
import 'features/prayer_times/data/repositories/prayer_times_repository_impl.dart';
import 'features/prayer_times/domain/repositories/prayer_times_repository.dart';
import 'features/prayer_times/domain/usecases/get_today_prayer_times.dart';
import 'features/prayer_times/presentation/cubit/prayer_times_cubit.dart';
import 'features/qibla_direction/data/repositories/qibla_repository_impl.dart';
import 'features/qibla_direction/domain/repositories/qibla_repository.dart';
import 'features/qibla_direction/domain/usecases/get_qibla_direction.dart';
import 'features/qibla_direction/presentation/cubit/qibla_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  _initLocation();
  _initPrayerTimes();
  _initQibla();
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

void _initQibla() {
  sl.registerFactory(() => QiblaCubit(getQiblaDirection: sl()));

  sl.registerLazySingleton(() => GetQiblaDirection(sl()));

  sl.registerLazySingleton<QiblaRepository>(
    () => QiblaRepositoryImpl(locationRepository: sl()),
  );
}

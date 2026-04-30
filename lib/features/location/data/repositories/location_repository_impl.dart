import 'package:dartz/dartz.dart';

import 'package:quran_app/core/error/exceptions.dart';
import 'package:quran_app/core/error/failures.dart';
import 'package:quran_app/features/location/data/datasources/location_local_data_source.dart';
import 'package:quran_app/features/location/domain/entities/coordinates.dart';
import 'package:quran_app/features/location/domain/repositories/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationLocalDataSource dataSource;

  const LocationRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, Coordinates>> getCurrentCoordinates() async {
    try {
      final coords = await dataSource.getCurrentCoordinates();
      return Right(coords);
    } on LocationException catch (e) {
      return Left(LocationFailure(e.message));
    }
  }
}

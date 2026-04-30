import 'package:dartz/dartz.dart';

import 'package:quran_app/core/error/failures.dart';
import 'package:quran_app/features/location/domain/entities/coordinates.dart';

abstract class LocationRepository {
  Future<Either<Failure, Coordinates>> getCurrentCoordinates();
}

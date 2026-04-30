import 'package:dartz/dartz.dart';

import 'package:quran_app/core/error/failures.dart';
import 'package:quran_app/core/usecase/usecase.dart';
import 'package:quran_app/features/location/domain/entities/coordinates.dart';
import 'package:quran_app/features/location/domain/repositories/location_repository.dart';

class GetCurrentCoordinates implements UseCase<Coordinates, NoParams> {
  final LocationRepository repository;

  const GetCurrentCoordinates(this.repository);

  @override
  Future<Either<Failure, Coordinates>> call(NoParams params) {
    return repository.getCurrentCoordinates();
  }
}

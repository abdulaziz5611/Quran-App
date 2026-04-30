import 'package:dartz/dartz.dart';

import 'package:quran_app/core/error/failures.dart';
import 'package:quran_app/core/usecase/usecase.dart';
import 'package:quran_app/features/qibla_direction/domain/entities/qibla_direction.dart';
import 'package:quran_app/features/qibla_direction/domain/repositories/qibla_repository.dart';

class GetQiblaDirection implements UseCase<QiblaDirection, NoParams> {
  final QiblaRepository repository;

  const GetQiblaDirection(this.repository);

  @override
  Future<Either<Failure, QiblaDirection>> call(NoParams params) {
    return repository.getQiblaDirection();
  }
}

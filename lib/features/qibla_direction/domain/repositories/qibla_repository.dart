import 'package:dartz/dartz.dart';

import 'package:quran_app/core/error/failures.dart';
import 'package:quran_app/features/qibla_direction/domain/entities/qibla_direction.dart';

abstract class QiblaRepository {
  Future<Either<Failure, QiblaDirection>> getQiblaDirection();
}

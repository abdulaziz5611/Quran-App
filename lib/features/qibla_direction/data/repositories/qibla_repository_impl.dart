import 'dart:math' as math;

import 'package:dartz/dartz.dart';

import 'package:quran_app/core/error/failures.dart';
import 'package:quran_app/features/location/domain/entities/coordinates.dart';
import 'package:quran_app/features/location/domain/repositories/location_repository.dart';
import 'package:quran_app/features/qibla_direction/domain/entities/qibla_direction.dart';
import 'package:quran_app/features/qibla_direction/domain/repositories/qibla_repository.dart';

class QiblaRepositoryImpl implements QiblaRepository {
  static const double _kaabaLat = 21.4225;
  static const double _kaabaLng = 39.8262;

  final LocationRepository locationRepository;

  const QiblaRepositoryImpl({required this.locationRepository});

  @override
  Future<Either<Failure, QiblaDirection>> getQiblaDirection() async {
    final coordsResult = await locationRepository.getCurrentCoordinates();
    return coordsResult.map(
      (coords) => QiblaDirection(bearingFromNorth: _bearingToKaaba(coords)),
    );
  }

  /// Initial-bearing (great-circle) from `from` to the Kaaba, in degrees
  /// clockwise from true north, normalised to [0, 360).
  double _bearingToKaaba(Coordinates from) {
    final phi1 = _toRad(from.latitude);
    final phi2 = _toRad(_kaabaLat);
    final deltaLambda = _toRad(_kaabaLng - from.longitude);

    final y = math.sin(deltaLambda) * math.cos(phi2);
    final x = math.cos(phi1) * math.sin(phi2) -
        math.sin(phi1) * math.cos(phi2) * math.cos(deltaLambda);

    final theta = math.atan2(y, x);
    return (_toDeg(theta) + 360) % 360;
  }

  double _toRad(double deg) => deg * math.pi / 180;
  double _toDeg(double rad) => rad * 180 / math.pi;
}

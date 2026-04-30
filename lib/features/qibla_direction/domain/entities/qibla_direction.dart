import 'package:equatable/equatable.dart';

class QiblaDirection extends Equatable {
  /// Bearing to the Kaaba in degrees, measured clockwise from true north.
  /// Range: [0, 360).
  final double bearingFromNorth;

  const QiblaDirection({required this.bearingFromNorth});

  @override
  List<Object?> get props => [bearingFromNorth];
}

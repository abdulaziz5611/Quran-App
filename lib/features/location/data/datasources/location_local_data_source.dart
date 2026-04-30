import 'package:quran_app/core/error/exceptions.dart';
import 'package:quran_app/features/location/domain/entities/coordinates.dart';

abstract class LocationLocalDataSource {
  /// Throws [LocationException] on failure.
  Future<Coordinates> getCurrentCoordinates();
}

/// Hardcoded fallback (Mecca). Replace with a `geolocator`-backed impl
/// once Android/iOS permission config is in place.
class LocationLocalDataSourceImpl implements LocationLocalDataSource {
  static const double _meccaLat = 21.4225;
  static const double _meccaLng = 39.8262;

  @override
  Future<Coordinates> getCurrentCoordinates() async {
    try {
      return const Coordinates(latitude: _meccaLat, longitude: _meccaLng);
    } catch (e) {
      throw LocationException(e.toString());
    }
  }
}

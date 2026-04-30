class ServerException implements Exception {
  final String message;
  const ServerException(this.message);
}

class CacheException implements Exception {
  final String message;
  const CacheException(this.message);
}

class LocationException implements Exception {
  final String message;
  const LocationException(this.message);
}

class CalculationException implements Exception {
  final String message;
  const CalculationException(this.message);
}

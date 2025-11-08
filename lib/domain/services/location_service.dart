abstract class LocationService {
  Future<bool> ensurePermission();
  Future<({double lat, double lon})> getCurrent();
  Future<double> distanceBetween(
    double aLat,
    double aLon,
    double bLat,
    double bLon,
  );
}

import 'dart:math';

import '../../domain/services/location_service.dart';

class MockLocationService implements LocationService {
  MockLocationService({
    this.forceInsideRadius = true,
    this.mockLat = -12.9777,
    this.mockLon = -38.5016,
  });

  final bool forceInsideRadius;
  final double mockLat;
  final double mockLon;

  @override
  Future<bool> ensurePermission() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  Future<({double lat, double lon})> getCurrent() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return (lat: mockLat, lon: mockLon);
  }

  @override
  Future<double> distanceBetween(
    double aLat,
    double aLon,
    double bLat,
    double bLon,
  ) async {
    await Future.delayed(const Duration(milliseconds: 200));
    if (forceInsideRadius) {
      return 50; // garante sucesso dentro do raio de 150m
    }
    return _haversine(aLat, aLon, bLat, bLon);
  }

  double _haversine(double lat1, double lon1, double lat2, double lon2) {
    const earthRadius = 6371000; // metros
    final dLat = _degToRad(lat2 - lat1);
    final dLon = _degToRad(lon2 - lon1);
    final a =
        pow(sin(dLat / 2), 2) + cos(_degToRad(lat1)) * cos(_degToRad(lat2)) * pow(sin(dLon / 2), 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadius * c;
  }

  double _degToRad(double degree) => degree * pi / 180;
}

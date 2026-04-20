import 'package:core_flutter/core_flutter.dart';
import '../entities/vehicle.dart';

abstract class VehicleRepository {
  Future<Either<Failure, List<Vehicle>>> getNearbyVehicles({
    required double lat,
    required double lng,
    double radiusKm = 2.0,
  });
  Future<Either<Failure, Vehicle>> getVehicle(String id);
}

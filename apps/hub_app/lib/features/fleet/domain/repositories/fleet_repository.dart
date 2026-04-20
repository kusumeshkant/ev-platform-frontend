import 'package:core_flutter/core_flutter.dart';

class FleetVehicle {
  final String id, model, status;
  final int batteryLevel;
  const FleetVehicle({required this.id, required this.model, required this.status, required this.batteryLevel});
  factory FleetVehicle.fromJson(Map<String, dynamic> j) => FleetVehicle(
    id: j['id'] as String, model: j['model'] as String,
    status: j['status'] as String, batteryLevel: j['batteryLevel'] as int,
  );
}

abstract class FleetRepository {
  Future<Either<Failure, List<FleetVehicle>>> getFleet(String hubId);
}

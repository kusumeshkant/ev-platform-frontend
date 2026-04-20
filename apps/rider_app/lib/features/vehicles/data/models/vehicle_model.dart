import '../../domain/entities/vehicle.dart';

class VehicleModel extends Vehicle {
  const VehicleModel({
    required super.id,
    required super.model,
    super.imageUrl,
    required super.batteryLevel,
    required super.distanceMeters,
    required super.ratePerMinute,
    required super.status,
    required super.location,
    super.hubId,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) => VehicleModel(
    id:            json['id']           as String,
    model:         json['model']        as String,
    imageUrl:      json['imageUrl']     as String?,
    batteryLevel:  json['batteryLevel'] as int,
    distanceMeters:(json['distanceMeters'] as num).toDouble(),
    ratePerMinute: (json['ratePerMinute'] as num).toDouble(),
    status:        _parseStatus(json['status'] as String),
    location:      VehicleLocation(
      (json['lat'] as num).toDouble(),
      (json['lng'] as num).toDouble(),
    ),
    hubId: json['hubId'] as String?,
  );

  static VehicleStatus _parseStatus(String s) => switch (s) {
    'available'   => VehicleStatus.available,
    'in_ride'     => VehicleStatus.inRide,
    'low_battery' => VehicleStatus.lowBattery,
    _             => VehicleStatus.offline,
  };
}

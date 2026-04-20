import '../../domain/entities/ride.dart';

class RideModel extends Ride {
  const RideModel({
    required super.id, required super.vehicleId, required super.userId,
    required super.status, required super.startTime,
    super.endTime, super.distanceKm, super.totalFare,
    required super.startLat, required super.startLng,
    super.endLat, super.endLng,
  });

  factory RideModel.fromJson(Map<String, dynamic> json) => RideModel(
    id:         json['id']        as String,
    vehicleId:  json['vehicleId'] as String,
    userId:     json['userId']    as String,
    status:     _status(json['status'] as String),
    startTime:  DateTime.parse(json['startTime'] as String),
    endTime:    json['endTime'] != null ? DateTime.parse(json['endTime'] as String) : null,
    distanceKm: (json['distanceKm'] as num?)?.toDouble(),
    totalFare:  (json['totalFare']  as num?)?.toDouble(),
    startLat:   (json['startLat'] as num).toDouble(),
    startLng:   (json['startLng'] as num).toDouble(),
    endLat:     (json['endLat'] as num?)?.toDouble(),
    endLng:     (json['endLng'] as num?)?.toDouble(),
  );

  static RideStatus _status(String s) => switch (s) {
    'active'    => RideStatus.active,
    'completed' => RideStatus.completed,
    _           => RideStatus.cancelled,
  };
}

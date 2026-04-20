enum RideStatus { active, completed, cancelled }

class Ride {
  final String id;
  final String vehicleId;
  final String userId;
  final RideStatus status;
  final DateTime startTime;
  final DateTime? endTime;
  final double? distanceKm;
  final double? totalFare;
  final double startLat, startLng;
  final double? endLat, endLng;

  const Ride({
    required this.id,
    required this.vehicleId,
    required this.userId,
    required this.status,
    required this.startTime,
    this.endTime,
    this.distanceKm,
    this.totalFare,
    required this.startLat,
    required this.startLng,
    this.endLat,
    this.endLng,
  });

  Duration get duration => (endTime ?? DateTime.now()).difference(startTime);
  bool get isActive => status == RideStatus.active;
}

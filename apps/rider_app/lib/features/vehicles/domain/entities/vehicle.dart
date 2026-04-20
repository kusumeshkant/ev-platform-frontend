enum VehicleStatus { available, inRide, offline, lowBattery }

class VehicleLocation {
  final double lat;
  final double lng;
  const VehicleLocation(this.lat, this.lng);
}

class Vehicle {
  final String id;
  final String model;
  final String? imageUrl;
  final int batteryLevel;
  final double distanceMeters;
  final double ratePerMinute;
  final VehicleStatus status;
  final VehicleLocation location;
  final String? hubId;

  const Vehicle({
    required this.id,
    required this.model,
    this.imageUrl,
    required this.batteryLevel,
    required this.distanceMeters,
    required this.ratePerMinute,
    required this.status,
    required this.location,
    this.hubId,
  });

  bool get isAvailable => status == VehicleStatus.available;
  double get distanceKm => distanceMeters / 1000;
}

import 'package:core_flutter/core_flutter.dart';
import '../entities/ride.dart';

abstract class RideRepository {
  Future<Either<Failure, Ride>>       startRide(String vehicleId);
  Future<Either<Failure, Ride>>       endRide(String rideId);
  Future<Either<Failure, Ride?>>      getActiveRide();
  Future<Either<Failure, List<Ride>>> getRideHistory({int page = 1});
}

import 'package:core_flutter/core_flutter.dart';
import '../../domain/entities/ride.dart';
import '../../domain/repositories/ride_repository.dart';
import '../datasources/ride_remote_datasource.dart';

class RideRepositoryImpl implements RideRepository {
  final RideRemoteDataSource _remote;
  const RideRepositoryImpl(this._remote);

  @override
  Future<Either<Failure, Ride>> startRide(String vehicleId) =>
      _wrap(() => _remote.startRide(vehicleId));

  @override
  Future<Either<Failure, Ride>> endRide(String rideId) =>
      _wrap(() => _remote.endRide(rideId));

  @override
  Future<Either<Failure, Ride?>> getActiveRide() async {
    try { return Right(await _remote.getActiveRide()); }
    on AppException catch (e) { return Left(ServerFailure(e.message)); }
    catch (_) { return const Left(UnknownFailure()); }
  }

  @override
  Future<Either<Failure, List<Ride>>> getRideHistory({int page = 1}) async {
    try { return Right(await _remote.getRideHistory(page: page)); }
    on AppException catch (e) { return Left(ServerFailure(e.message)); }
    catch (_) { return const Left(UnknownFailure()); }
  }

  Future<Either<Failure, Ride>> _wrap(Future<Ride> Function() fn) async {
    try { return Right(await fn()); }
    on AppException catch (e) { return Left(ServerFailure(e.message)); }
    catch (_) { return const Left(UnknownFailure()); }
  }
}

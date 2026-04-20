import 'package:core_flutter/core_flutter.dart';
import '../../domain/entities/vehicle.dart';
import '../../domain/repositories/vehicle_repository.dart';
import '../datasources/vehicle_remote_datasource.dart';

class VehicleRepositoryImpl implements VehicleRepository {
  final VehicleRemoteDataSource _remote;
  const VehicleRepositoryImpl(this._remote);

  @override
  Future<Either<Failure, List<Vehicle>>> getNearbyVehicles({required double lat, required double lng, double radiusKm = 2.0}) async {
    try {
      final vehicles = await _remote.getNearbyVehicles(lat: lat, lng: lng, radiusKm: radiusKm);
      return Right(vehicles);
    } on AppException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, Vehicle>> getVehicle(String id) async {
    try {
      return Right(await _remote.getVehicle(id));
    } on AppException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }
}

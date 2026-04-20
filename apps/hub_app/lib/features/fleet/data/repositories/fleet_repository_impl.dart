import 'package:core_flutter/core_flutter.dart';
import '../../domain/repositories/fleet_repository.dart';
import '../datasources/fleet_remote_datasource.dart';

class FleetRepositoryImpl implements FleetRepository {
  final FleetRemoteDataSource _remote;
  const FleetRepositoryImpl(this._remote);

  @override
  Future<Either<Failure, List<FleetVehicle>>> getFleet(String hubId) async {
    try { return Right(await _remote.getFleet(hubId)); }
    on AppException catch (e) { return Left(ServerFailure(e.message)); }
    catch (_) { return const Left(UnknownFailure()); }
  }
}

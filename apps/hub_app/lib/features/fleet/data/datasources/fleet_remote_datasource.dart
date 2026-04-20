import 'package:core_flutter/core_flutter.dart';
import '../../domain/repositories/fleet_repository.dart';

abstract class FleetRemoteDataSource {
  Future<List<FleetVehicle>> getFleet(String hubId);
}

class FleetRemoteDataSourceImpl implements FleetRemoteDataSource {
  final ApiClient _client;
  const FleetRemoteDataSourceImpl(this._client);
  @override
  Future<List<FleetVehicle>> getFleet(String hubId) async {
    final r = await _client.get<List<FleetVehicle>>(
      '${ApiConstants.hubs}/$hubId/vehicles',
      mapper: (d) => (d as List).map((e) => FleetVehicle.fromJson(e as Map<String, dynamic>)).toList(),
    );
    return r.fold((f) => throw AppException(f.message), (v) => v);
  }
}

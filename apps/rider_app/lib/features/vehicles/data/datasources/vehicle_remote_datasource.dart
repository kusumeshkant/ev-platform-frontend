import 'package:core_flutter/core_flutter.dart';
import '../models/vehicle_model.dart';

abstract class VehicleRemoteDataSource {
  Future<List<VehicleModel>> getNearbyVehicles({required double lat, required double lng, double radiusKm = 2.0});
  Future<VehicleModel> getVehicle(String id);
}

class VehicleRemoteDataSourceImpl implements VehicleRemoteDataSource {
  final ApiClient _client;
  const VehicleRemoteDataSourceImpl(this._client);

  @override
  Future<List<VehicleModel>> getNearbyVehicles({required double lat, required double lng, double radiusKm = 2.0}) async {
    final result = await _client.get<List<VehicleModel>>(
      ApiConstants.nearbyVehicles,
      queryParams: {'lat': lat, 'lng': lng, 'radius': radiusKm},
      mapper: (data) => (data as List).map((e) => VehicleModel.fromJson(e as Map<String, dynamic>)).toList(),
    );
    return result.fold((f) => throw AppException(f.message), (v) => v);
  }

  @override
  Future<VehicleModel> getVehicle(String id) async {
    final result = await _client.get<VehicleModel>(
      '${ApiConstants.vehicles}/$id',
      mapper: (data) => VehicleModel.fromJson(data as Map<String, dynamic>),
    );
    return result.fold((f) => throw AppException(f.message), (v) => v);
  }
}

import 'package:core_flutter/core_flutter.dart';
import '../models/ride_model.dart';

abstract class RideRemoteDataSource {
  Future<RideModel>        startRide(String vehicleId);
  Future<RideModel>        endRide(String rideId);
  Future<RideModel?>       getActiveRide();
  Future<List<RideModel>>  getRideHistory({int page = 1});
}

class RideRemoteDataSourceImpl implements RideRemoteDataSource {
  final ApiClient _client;
  const RideRemoteDataSourceImpl(this._client);

  @override
  Future<RideModel> startRide(String vehicleId) async {
    final r = await _client.post<RideModel>(
      ApiConstants.rides,
      data: {'vehicleId': vehicleId},
      mapper: (d) => RideModel.fromJson(d as Map<String, dynamic>),
    );
    return r.fold((f) => throw AppException(f.message), (v) => v);
  }

  @override
  Future<RideModel> endRide(String rideId) async {
    final r = await _client.put<RideModel>(
      '${ApiConstants.rides}/$rideId/end',
      mapper: (d) => RideModel.fromJson(d as Map<String, dynamic>),
    );
    return r.fold((f) => throw AppException(f.message), (v) => v);
  }

  @override
  Future<RideModel?> getActiveRide() async {
    final r = await _client.get<RideModel?>(
      ApiConstants.activeRide,
      mapper: (d) => d != null ? RideModel.fromJson(d as Map<String, dynamic>) : null,
    );
    return r.fold((f) => throw AppException(f.message), (v) => v);
  }

  @override
  Future<List<RideModel>> getRideHistory({int page = 1}) async {
    final r = await _client.get<List<RideModel>>(
      ApiConstants.rides,
      queryParams: {'page': page, 'limit': 20},
      mapper: (d) => (d as List).map((e) => RideModel.fromJson(e as Map<String, dynamic>)).toList(),
    );
    return r.fold((f) => throw AppException(f.message), (v) => v);
  }
}

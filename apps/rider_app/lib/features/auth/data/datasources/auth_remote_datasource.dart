import 'package:core_flutter/core_flutter.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<void>      sendOtp(String phone);
  Future<UserModel> verifyOtp(String phone, String otp);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient _client;
  const AuthRemoteDataSourceImpl(this._client);

  @override
  Future<void> sendOtp(String phone) async {
    final result = await _client.post<void>(
      ApiConstants.sendOtp,
      data: {'phone': phone},
      mapper: (_) {},
    );
    result.fold(
      (failure) => throw AppException(failure.message),
      (_) {},
    );
  }

  @override
  Future<UserModel> verifyOtp(String phone, String otp) async {
    final result = await _client.post<Map<String, dynamic>>(
      ApiConstants.verifyOtp,
      data: {'phone': phone, 'otp': otp},
      mapper: (data) => data as Map<String, dynamic>,
    );
    return result.fold(
      (failure) => throw AppException(failure.message),
      (data) {
        // Save tokens before returning user
        return UserModel.fromJson(data['user'] as Map<String, dynamic>);
      },
    );
  }
}

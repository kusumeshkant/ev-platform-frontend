import 'package:core_flutter/core_flutter.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class VerifyOtp {
  final AuthRepository _repository;
  const VerifyOtp(this._repository);

  Future<Either<Failure, User>> call(String phone, String otp) =>
      _repository.verifyOtp(phone, otp);
}

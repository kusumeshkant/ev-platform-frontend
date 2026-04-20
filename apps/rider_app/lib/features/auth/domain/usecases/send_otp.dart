import 'package:core_flutter/core_flutter.dart';
import '../repositories/auth_repository.dart';

class SendOtp {
  final AuthRepository _repository;
  const SendOtp(this._repository);

  Future<Either<Failure, void>> call(String phone) => _repository.sendOtp(phone);
}

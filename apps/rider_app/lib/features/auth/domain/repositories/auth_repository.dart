import 'package:core_flutter/core_flutter.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>>   sendOtp(String phone);
  Future<Either<Failure, User>>   verifyOtp(String phone, String otp);
  Future<Either<Failure, User?>>  getCurrentUser();
  Future<Either<Failure, void>>   logout();
}

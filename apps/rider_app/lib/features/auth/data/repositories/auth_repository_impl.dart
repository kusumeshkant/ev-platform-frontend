import 'package:core_flutter/core_flutter.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remote;
  final TokenStorage _tokenStorage;

  const AuthRepositoryImpl(this._remote, this._tokenStorage);

  @override
  Future<Either<Failure, void>> sendOtp(String phone) async {
    try {
      await _remote.sendOtp(phone);
      return const Right(null);
    } on AppException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, User>> verifyOtp(String phone, String otp) async {
    try {
      final user = await _remote.verifyOtp(phone, otp);
      return Right(user);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } on AppException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, User?>> getCurrentUser() async {
    final hasToken = await _tokenStorage.hasToken;
    if (!hasToken) return const Right(null);
    // In production: fetch /users/me
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> logout() async {
    await _tokenStorage.clear();
    return const Right(null);
  }
}

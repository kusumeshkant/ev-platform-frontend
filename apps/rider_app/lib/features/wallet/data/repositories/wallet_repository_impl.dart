import 'package:core_flutter/core_flutter.dart';
import '../../domain/entities/wallet.dart';
import '../../domain/repositories/wallet_repository.dart';
import '../datasources/wallet_remote_datasource.dart';

class WalletRepositoryImpl implements WalletRepository {
  final WalletRemoteDataSource _remote;
  const WalletRepositoryImpl(this._remote);

  @override
  Future<Either<Failure, Wallet>> getWallet() async {
    try { return Right(await _remote.getWallet()); }
    on AppException catch (e) { return Left(ServerFailure(e.message)); }
    catch (_) { return const Left(UnknownFailure()); }
  }

  @override
  Future<Either<Failure, Wallet>> topup(double amount, String paymentId) async {
    try { return Right(await _remote.topup(amount, paymentId)); }
    on AppException catch (e) { return Left(ServerFailure(e.message)); }
    catch (_) { return const Left(UnknownFailure()); }
  }
}

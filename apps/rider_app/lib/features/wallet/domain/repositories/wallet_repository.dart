import 'package:core_flutter/core_flutter.dart';
import '../entities/wallet.dart';

abstract class WalletRepository {
  Future<Either<Failure, Wallet>> getWallet();
  Future<Either<Failure, Wallet>> topup(double amount, String paymentId);
}

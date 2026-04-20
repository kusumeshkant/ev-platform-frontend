import 'package:core_flutter/core_flutter.dart';
import '../models/wallet_model.dart';

abstract class WalletRemoteDataSource {
  Future<WalletModel> getWallet();
  Future<WalletModel> topup(double amount, String paymentId);
}

class WalletRemoteDataSourceImpl implements WalletRemoteDataSource {
  final ApiClient _client;
  const WalletRemoteDataSourceImpl(this._client);

  @override
  Future<WalletModel> getWallet() async {
    final r = await _client.get<WalletModel>(ApiConstants.wallet, mapper: (d) => WalletModel.fromJson(d as Map<String, dynamic>));
    return r.fold((f) => throw AppException(f.message), (v) => v);
  }

  @override
  Future<WalletModel> topup(double amount, String paymentId) async {
    final r = await _client.post<WalletModel>(
      ApiConstants.walletTopup,
      data: {'amount': amount, 'paymentId': paymentId},
      mapper: (d) => WalletModel.fromJson(d as Map<String, dynamic>),
    );
    return r.fold((f) => throw AppException(f.message), (v) => v);
  }
}

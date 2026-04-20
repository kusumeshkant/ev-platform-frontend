import '../../domain/entities/wallet.dart';

class WalletTransactionModel extends WalletTransaction {
  const WalletTransactionModel({
    required super.id, required super.type, required super.amount,
    required super.description, required super.createdAt, required super.isCredit,
  });

  factory WalletTransactionModel.fromJson(Map<String, dynamic> json) => WalletTransactionModel(
    id: json['id'] as String,
    type: _type(json['type'] as String),
    amount: (json['amount'] as num).toDouble(),
    description: json['description'] as String,
    createdAt: DateTime.parse(json['createdAt'] as String),
    isCredit: json['isCredit'] as bool,
  );

  static TransactionType _type(String s) => switch (s) {
    'topup'    => TransactionType.topup,
    'ride'     => TransactionType.ride,
    'refund'   => TransactionType.refund,
    'referral' => TransactionType.referral,
    _          => TransactionType.ride,
  };
}

class WalletModel extends Wallet {
  const WalletModel({required super.userId, required super.balance, super.transactions});

  factory WalletModel.fromJson(Map<String, dynamic> json) => WalletModel(
    userId:  json['userId'] as String,
    balance: (json['balance'] as num).toDouble(),
    transactions: (json['transactions'] as List? ?? [])
        .map((e) => WalletTransactionModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

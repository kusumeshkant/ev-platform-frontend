enum TransactionType { topup, ride, refund, referral }

class WalletTransaction {
  final String id;
  final TransactionType type;
  final double amount;
  final String description;
  final DateTime createdAt;
  final bool isCredit;

  const WalletTransaction({
    required this.id,
    required this.type,
    required this.amount,
    required this.description,
    required this.createdAt,
    required this.isCredit,
  });
}

class Wallet {
  final String userId;
  final double balance;
  final List<WalletTransaction> transactions;

  const Wallet({required this.userId, required this.balance, this.transactions = const []});
}

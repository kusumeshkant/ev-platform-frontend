import 'package:intl/intl.dart';

abstract final class CurrencyFormatter {
  static String format(
    double amount, {
    String symbol = '₹',
    String locale = 'en_IN',
    int decimalDigits = 2,
  }) {
    final formatter = NumberFormat.currency(
      locale:        locale,
      symbol:        symbol,
      decimalDigits: decimalDigits,
    );
    return formatter.format(amount);
  }

  static String compact(double amount, {String symbol = '₹'}) {
    if (amount >= 100000) return '$symbol${(amount / 100000).toStringAsFixed(1)}L';
    if (amount >= 1000)   return '$symbol${(amount / 1000).toStringAsFixed(1)}K';
    return format(amount, symbol: symbol, decimalDigits: 0);
  }
}

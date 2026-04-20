class User {
  final String id;
  final String phone;
  final String? name;
  final String? email;
  final String? avatarUrl;
  final double walletBalance;
  final DateTime createdAt;

  const User({
    required this.id,
    required this.phone,
    this.name,
    this.email,
    this.avatarUrl,
    required this.walletBalance,
    required this.createdAt,
  });

  User copyWith({String? name, String? email, String? avatarUrl, double? walletBalance}) => User(
    id: id, phone: phone, createdAt: createdAt,
    name: name ?? this.name,
    email: email ?? this.email,
    avatarUrl: avatarUrl ?? this.avatarUrl,
    walletBalance: walletBalance ?? this.walletBalance,
  );
}

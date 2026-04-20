import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.phone,
    super.name,
    super.email,
    super.avatarUrl,
    required super.walletBalance,
    required super.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id:            json['id']            as String,
    phone:         json['phone']         as String,
    name:          json['name']          as String?,
    email:         json['email']         as String?,
    avatarUrl:     json['avatarUrl']     as String?,
    walletBalance: (json['walletBalance'] as num).toDouble(),
    createdAt:     DateTime.parse(json['createdAt'] as String),
  );

  Map<String, dynamic> toJson() => {
    'id': id, 'phone': phone, 'name': name, 'email': email,
    'avatarUrl': avatarUrl, 'walletBalance': walletBalance,
    'createdAt': createdAt.toIso8601String(),
  };
}

import 'package:the_write_blueprint/core/common/entities/user.dart';

class UserModel extends User {
  UserModel(
      {required super.email,
      required super.name,
      required super.username,
      required super.avatarUrl,
      required super.id});

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      username: map['username'] ?? '',
      avatarUrl: map['avatarUrl'] ?? '',
      id: map['id'] ?? '',
    );
  }

  UserModel copyWith({
    String? id,
    email,
    name,
    username,
    avatarUrl,
  }) {
    return UserModel(
        avatarUrl: avatarUrl ?? this.avatarUrl,
        id: id ?? this.id,
        email: email ?? this.email,
        username: username ?? this.username,
        name: name ?? this.name);
  }
}

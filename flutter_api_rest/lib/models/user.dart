import 'package:meta/meta.dart';

class User {
  final String id, username, email;
  final DateTime createdAt, updatedAt;

  User({
    @required this.id,
    @required this.username,
    @required this.email,
    @required this.createdAt,
    @required this.updatedAt,
  });

  static User fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      username: json['username'],
      email: json['email'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

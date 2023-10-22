import 'dart:convert';

class UpdateUser {
  final int id;
  final String name;
  final String email;
  // final dynamic emailVerifiedAt;
  // final String createdAt;
  // final String updatedAt;

  UpdateUser({
    required this.id,
    required this.name,
    required this.email,
    // required this.emailVerifiedAt,
    // required this.createdAt,
    // required this.updatedAt,
  });

  factory UpdateUser.fromJson(Map<String, dynamic> json) => UpdateUser(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        // emailVerifiedAt: json["email_verified_at"],
        // createdAt: json["created_at"],
        // updatedAt: json["updated_at"],
      );
}

import 'dart:convert';
import 'package:http/http.dart' as http;

class ShowUser {
  final int id;
  final String name;
  final String email;
  final dynamic emailVerifiedAt;
  final String createdAt;
  final String updatedAt;

  ShowUser({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ShowUser.fromJson(Map<String, dynamic> json) => ShowUser(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );
}

Future<ShowUser> fetchShowUser(int userId) async {
  final response = await http.get(
    Uri.parse('http://10.0.2.2:8000/api/user/$userId'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': '*/*',
      'connection': 'keep-alive',
      // 'Authorization': 'Bearer ' + globals.jwtToken,
    },
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return ShowUser.fromJson(data);
  } else {
    throw Exception('Failed to load data from API');
  }
}

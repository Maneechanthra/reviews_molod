import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiResponse {
  final String textFromApi;

  const ApiResponse({
    required this.textFromApi,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      textFromApi: json['message'],
    );
  }
}

class LoginResponse {
  final String email;
  final String jwtToken;
  final int userId;
  final String name;
  final int loginStatus;

  const LoginResponse({
    required this.email,
    required this.jwtToken,
    required this.userId,
    required this.name,
    required this.loginStatus,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      email: json['email'],
      jwtToken: json['jwt_token'],
      userId: json['user_id'],
      name: json['name'],
      loginStatus: json['status'],
    );
  }

  String getToken() {
    return jwtToken;
  }
}

Future<ApiResponse> fetchApi() async {
  final response = await http
      .get(Uri.parse('http://10.0.2.2:8000/api'), headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': "*/*",
    'connection': 'keep-alive'
  });

  if (response.statusCode == 200) {
    if (response.body != null) {
      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('API response is null or empty.');
    }
  } else {
    throw Exception('Failed to load data from API');
  }
}

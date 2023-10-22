import 'dart:convert';

import 'package:flutter/foundation.dart';
// import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class ApiResponseRegister {
  final String textFromApi;

  const ApiResponseRegister({
    required this.textFromApi,
  });

  factory ApiResponseRegister.fromJson(Map<String, dynamic> json) {
    return ApiResponseRegister(
      textFromApi: json['message'],
    );
  }
}

class RegisterResponse {
  final String name;
  final String email;
  // final String telephone_number;
  // final String password;
  // final int registerStatus;

  RegisterResponse({
    required this.name,
    required this.email,
    // required this.telephone_number,
    // required this.password,
  });

  // required this.registerStatus

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      name: json['name'],
      email: json['email'],
      // telephone_number: json['telephone_number'],
      // password: json['password'],
      // registerStatus: json['status'],
    );
  }
}

Future<ApiResponseRegister> fetchApi() async {
  final response = await http.get(
    Uri.parse('http://10.0.2.2:8000/api'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': '*/*',
      'connection': 'keep-alive',
    },
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    if (response.body != null && response.body.isNotEmpty) {
      return ApiResponseRegister.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('API response is null or empty.');
    }
  } else {
    throw Exception('Failed to load data from API');
  }
}

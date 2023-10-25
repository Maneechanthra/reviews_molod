import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class ApiResponsePost {
  final String textFromApi;

  const ApiResponsePost({
    required this.textFromApi,
  });

  factory ApiResponsePost.fromJson(Map<String, dynamic> json) {
    return ApiResponsePost(
      textFromApi: json['message'],
    );
  }
}

class CategoryModel {
  String title;
  String body;
  int category;
  File img_content_1;
  File img_content_2;
  File img_content_3;
  String user_id;

  CategoryModel({
    required this.title,
    required this.body,
    required this.category,
    required this.img_content_1,
    required this.img_content_2,
    required this.img_content_3,
    required this.user_id,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      title: json["title"],
      body: json["body"],
      category: json["category"],
      user_id: json["user_id"],
      img_content_1: File(json['img_content_1']),
      img_content_2: File(json['img_content_2']),
      img_content_3: File(json['img_content_3']),
    );
  }
}

Future<ApiResponsePost> fetchApiPost() async {
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
      return ApiResponsePost.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('API response is null or empty.');
    }
  } else {
    throw Exception('Failed to load data from API');
  }
}

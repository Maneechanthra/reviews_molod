import 'dart:convert';

import 'package:http/http.dart' as http;
import '/globals.dart' as globals;

class CategoriesModel {
  final int id;
  final String title;

  CategoriesModel({
    required this.id,
    required this.title,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
      id: json['id'],
      title: json['title'],
    );
  }
}

Future<List<CategoriesModel>> fetchCategories() async {
  final response = await http.get(
    Uri.parse('http://10.0.2.2:8000/api/categories'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': "*/*",
      'connection': 'keep-alive',
      'Authorization': 'Bearer ' + globals.jwtToken,
    },
  );
  print(response.body);
  print(response.statusCode);

  if (response.statusCode == 200 || response.statusCode == 201) {
    final data = json.decode(response.body) as List<dynamic>;
    return data.map((json) => CategoriesModel.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load data from API');
  }
}

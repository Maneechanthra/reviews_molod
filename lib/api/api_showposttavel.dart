import 'dart:convert';

import 'package:http/http.dart' as http;

class ShowPostTavel {
  final int id;
  final String title;
  final String body;
  final String img_content_1;
  final String img_content_2;
  final String img_content_3;
  final String created_at;

  ShowPostTavel({
    required this.id,
    required this.title,
    required this.body,
    required this.img_content_1,
    required this.img_content_2,
    required this.img_content_3,
    required this.created_at,
  });

  factory ShowPostTavel.fromJson(Map<String, dynamic> json) => ShowPostTavel(
        id: json["id"],
        title: json["title"],
        body: json["body"],
        img_content_1: json['img_content_1'],
        img_content_2: json['img_content_2'],
        img_content_3: json['img_content_3'],
        created_at: json["created_at"],
      );
}

Future<List<ShowPostTavel>> fetchShowPostTavel(int categoryId) async {
  final response = await http.get(
    Uri.parse('http://10.0.2.2:8000/api/posts/tavel/$categoryId'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': "*/*",
      'connection': 'keep-alive',
    },
  );
  print(response.body);
  print(response.statusCode);

  if (response.statusCode == 200) {
    final data = json.decode(response.body) as List<dynamic>;
    return data.map((json) => ShowPostTavel.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load data from API');
  }
}

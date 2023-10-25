import 'dart:convert';
import 'package:http/http.dart' as http;
import '/globals.dart' as globals;

class RecommentMOdel {
  final int id;
  final String title;
  final String body;
  final String imgContent1;
  final String imgContent2;
  final String imgContent3;
  final int category;
  final String createdAt;
  final String name;
  final String category_title;
  final int user_id;

  RecommentMOdel({
    required this.id,
    required this.title,
    required this.body,
    required this.imgContent1,
    required this.imgContent2,
    required this.imgContent3,
    required this.category,
    required this.createdAt,
    required this.name,
    required this.category_title,
    required this.user_id,
  });

  factory RecommentMOdel.fromJson(Map<String, dynamic> json) => RecommentMOdel(
        id: json["id"],
        title: json["title"],
        body: json["body"],
        imgContent1: json["img_content_1"],
        imgContent2: json["img_content_2"],
        imgContent3: json["img_content_3"],
        category: json["category"],
        createdAt: json["created_at"],
        name: json["name"],
        category_title: json["category_title"],
        user_id: json["user_id"],
      );
}

Future<List<RecommentMOdel>> fetchShowRecoment() async {
  final response = await http.get(
    Uri.parse('http://10.0.2.2:8000/api/recomment'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': '*/*',
      'connection': 'keep-alive',
      'Authorization': 'Bearer ' + globals.jwtToken,
    },
  );

  print(response.statusCode);
  print(response.body);

  if (response.statusCode == 200) {
    try {
      final data = json.decode(response.body) as List<dynamic>;
      return data.map((json) => RecommentMOdel.fromJson(json)).toList();
    } catch (e) {
      print('Error decoding JSON: $e');
      throw Exception('Failed to decode JSON data');
    }
  } else {
    print('HTTP error: ${response.statusCode}');
    throw Exception('Failed to load data from API');
  }
}

import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

class ShowDataProfile {
  final int post_id;
  final String post_title;
  final String title;
  final String body;
  final String imgContent1;
  final String imgContent2;
  final String imgContent3;
  final int category;
  final String name;
  final int id;
  final String created_at;

  ShowDataProfile({
    required this.post_id,
    required this.post_title,
    required this.title,
    required this.body,
    required this.imgContent1,
    required this.imgContent2,
    required this.imgContent3,
    required this.category,
    required this.name,
    required this.id,
    required this.created_at,
  });

  factory ShowDataProfile.fromJson(Map<String, dynamic> json) =>
      ShowDataProfile(
        post_id: json["post_id"],
        post_title: json["post_title"],
        title: json["title"],
        body: json["body"],
        imgContent1: json["img_content_1"],
        imgContent2: json["img_content_2"],
        imgContent3: json["img_content_3"],
        category: json["category"],
        name: json["name"],
        id: json["id"],
        created_at: json["created_at"],
      );
}

Future<List<ShowDataProfile>> fetchShowPostUser(int userId) async {
  final response = await http.get(
    Uri.parse('http://10.0.2.2:8000/api/post/showPost/$userId'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': '*/*',
      'connection': 'keep-alive',
    },
  );

  print(response.statusCode);
  print(response.body);

  if (response.statusCode == 200) {
    final List<dynamic> dataList = json.decode(response.body);
    final List<ShowDataProfile> data = dataList
        .map((item) => ShowDataProfile.fromJson(item))
        .toList(growable: false); // สร้าง List แบบไม่เปลี่ยนแปลง
    return data;
  } else {
    throw Exception('Failed to load data from API');
  }
}

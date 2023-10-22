import 'dart:convert';
import 'package:http/http.dart' as http;

class EditPost {
  final int id;
  final String title;
  final String body;
  final String imgContent1;
  final String imgContent2;
  final String imgContent3;
  final int category;
  final int userId;
  final String createdAt;
  final String updatedAt;
  final dynamic deletedAt;

  EditPost({
    required this.id,
    required this.title,
    required this.body,
    required this.imgContent1,
    required this.imgContent2,
    required this.imgContent3,
    required this.category,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory EditPost.fromJson(Map<String, dynamic> json) => EditPost(
        id: json["id"],
        title: json["title"],
        body: json["body"],
        imgContent1: json["img_content_1"],
        imgContent2: json["img_content_2"],
        imgContent3: json["img_content_3"],
        category: json["category"],
        userId: json["user_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
      );
}

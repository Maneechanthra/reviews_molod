class ShowDetailPost {
  final int id;
  final String title;
  final String body;
  final String imgContent1;
  final String imgContent2;
  final String imgContent3;
  final String createdAt; // เพิ่มฟิลด์ created_at
  final String categoryTitle; // เพิ่มฟิลด์ categoryTitle

  ShowDetailPost({
    required this.id,
    required this.title,
    required this.body,
    required this.imgContent1,
    required this.imgContent2,
    required this.imgContent3,
    required this.createdAt,
    required this.categoryTitle,
  });

  factory ShowDetailPost.fromJson(Map<String, dynamic> json) => ShowDetailPost(
        id: json["id"],
        title: json["title"],
        body: json["body"],
        imgContent1: json["img_content_1"],
        imgContent2: json["img_content_2"],
        imgContent3: json["img_content_3"],
        createdAt: json["created_at"],
        categoryTitle: json["category_title"],
      );
}

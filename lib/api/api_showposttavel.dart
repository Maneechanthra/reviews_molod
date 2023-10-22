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

import 'dart:convert';

DetailsResponse detailsResponseFromJson(String str) =>
    DetailsResponse.fromJson(json.decode(str));

String detailsResponseToJson(DetailsResponse data) =>
    json.encode(data.toJson());

class DetailsResponse {
  bool status;
  Blog blog;

  DetailsResponse({
    required this.status,
    required this.blog,
  });

  factory DetailsResponse.fromJson(Map<String, dynamic> json) =>
      DetailsResponse(
        status: json["status"],
        blog: Blog.fromJson(json["blog"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "blog": blog.toJson(),
      };
}

class Blog {
  int id;
  DateTime createdAt;
  String image;
  String title;
  String content;
  int category;

  Blog({
    required this.id,
    required this.createdAt,
    required this.image,
    required this.title,
    required this.content,
    required this.category,
  });

  factory Blog.fromJson(Map<String, dynamic> json) => Blog(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        image: json["image"],
        title: json["title"],
        content: json["content"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "image": image,
        "title": title,
        "content": content,
        "category": category,
      };
}

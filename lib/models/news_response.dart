import 'dart:convert';

NewAndBlogResponse newAndBlogResponseFromJson(String str) => NewAndBlogResponse.fromJson(json.decode(str));

String newAndBlogResponseToJson(NewAndBlogResponse data) => json.encode(data.toJson());

class NewAndBlogResponse {
    bool status;
    List<BlogsCategory> blogsCategory;

    NewAndBlogResponse({
        required this.status,
        required this.blogsCategory,
    });

    factory NewAndBlogResponse.fromJson(Map<String, dynamic> json) => NewAndBlogResponse(
        status: json["status"],
        blogsCategory: List<BlogsCategory>.from(json["blogs_category"].map((x) => BlogsCategory.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "blogs_category": List<dynamic>.from(blogsCategory.map((x) => x.toJson())),
    };
}

class BlogsCategory {
    int id;
    String? name;

    BlogsCategory({
        required this.id,
        required this.name,
    });

    factory BlogsCategory.fromJson(Map<String, dynamic> json) => BlogsCategory(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}

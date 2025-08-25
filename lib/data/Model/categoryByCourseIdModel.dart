import 'dart:convert';

CorurseByCategoryIdModel corurseByCategoryIdModelFromJson(String str) =>
    CorurseByCategoryIdModel.fromJson(json.decode(str));

String corurseByCategoryIdModelToJson(CorurseByCategoryIdModel data) =>
    json.encode(data.toJson());

class CorurseByCategoryIdModel {
  Category category;
  List<Course> courses;
  int total;
  int pages;
  int currentPage;

  CorurseByCategoryIdModel({
    required this.category,
    required this.courses,
    required this.total,
    required this.pages,
    required this.currentPage,
  });

  factory CorurseByCategoryIdModel.fromJson(Map<String, dynamic> json) =>
      CorurseByCategoryIdModel(
        category: Category.fromJson(json["category"]),
        courses: List<Course>.from(
          (json["courses"] ?? []).map((x) => Course.fromJson(x)),
        ),
        total: json["total"] ?? 0,
        pages: json["pages"] ?? 0,
        currentPage: json["current_page"] ?? 1,
      );

  Map<String, dynamic> toJson() => {
    "category": category.toJson(),
    "courses": List<dynamic>.from(courses.map((x) => x.toJson())),
    "total": total,
    "pages": pages,
    "current_page": currentPage,
  };
}

class Category {
  int id;
  String name;
  String slug;

  Category({required this.id, required this.name, required this.slug});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"] ?? 0,
    name: json["name"] ?? '',
    slug: json["slug"] ?? '',
  );

  Map<String, dynamic> toJson() => {"id": id, "name": name, "slug": slug};
}

class Course {
  int id;
  String title;
  String excerpt;
  String thumbnail;
  String link;
  String price; // enum हटाकर string कर दिया
  String? enrolled; // nullable

  Course({
    required this.id,
    required this.title,
    required this.excerpt,
    required this.thumbnail,
    required this.link,
    required this.price,
    this.enrolled,
  });

  factory Course.fromJson(Map<String, dynamic> json) => Course(
    id: json["id"] ?? 0,
    title: json["title"] ?? '',
    excerpt: json["excerpt"] ?? '',
    thumbnail: json["thumbnail"] ?? '',
    link: json["link"] ?? '',
    price: json["price"] ?? 'Free', // default value दिया
    enrolled: json["enrolled"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "excerpt": excerpt,
    "thumbnail": thumbnail,
    "link": link,
    "price": price,
    "enrolled": enrolled,
  };
}

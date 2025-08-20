// To parse this JSON data, do
//
//     final corurseByCategoryIdModel = corurseByCategoryIdModelFromJson(jsonString);

import 'dart:convert';

CorurseByCategoryIdModel corurseByCategoryIdModelFromJson(String str) => CorurseByCategoryIdModel.fromJson(json.decode(str));

String corurseByCategoryIdModelToJson(CorurseByCategoryIdModel data) => json.encode(data.toJson());

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

    factory CorurseByCategoryIdModel.fromJson(Map<String, dynamic> json) => CorurseByCategoryIdModel(
        category: Category.fromJson(json["category"]),
        courses: List<Course>.from(json["courses"].map((x) => Course.fromJson(x))),
        total: json["total"],
        pages: json["pages"],
        currentPage: json["current_page"],
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

    Category({
        required this.id,
        required this.name,
        required this.slug,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
    };
}

class Course {
    int id;
    String title;
    String excerpt;
    String thumbnail;
    String link;
    Price price;
    dynamic enrolled;

    Course({
        required this.id,
        required this.title,
        required this.excerpt,
        required this.thumbnail,
        required this.link,
        required this.price,
        required this.enrolled,
    });

    factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json["id"],
        title: json["title"],
        excerpt: json["excerpt"],
        thumbnail: json["thumbnail"],
        link: json["link"],
        price: priceValues.map[json["price"]]!,
        enrolled: json["enrolled"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "excerpt": excerpt,
        "thumbnail": thumbnail,
        "link": link,
        "price": priceValues.reverse[price],
        "enrolled": enrolled,
    };
}

enum Price {
    THE_100000,
    THE_52500
}

final priceValues = EnumValues({
    "₹1,000.00": Price.THE_100000,
    "₹525.00": Price.THE_52500
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}

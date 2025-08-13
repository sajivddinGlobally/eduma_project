// To parse this JSON data, do
//
//     final allCategoryModel = allCategoryModelFromJson(jsonString);

import 'dart:convert';

AllCategoryModel allCategoryModelFromJson(String str) => AllCategoryModel.fromJson(json.decode(str));

String allCategoryModelToJson(AllCategoryModel data) => json.encode(data.toJson());

class AllCategoryModel {
    bool success;
    List<Datum> data;
    int total;

    AllCategoryModel({
        required this.success,
        required this.data,
        required this.total,
    });

    factory AllCategoryModel.fromJson(Map<String, dynamic> json) => AllCategoryModel(
        success: json["success"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "total": total,
    };
}

class Datum {
    int id;
    String name;
    String slug;
    String description;
    int count;
    String url;
    String thumbnail;
    String thumbnailId;

    Datum({
        required this.id,
        required this.name,
        required this.slug,
        required this.description,
        required this.count,
        required this.url,
        required this.thumbnail,
        required this.thumbnailId,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        description: json["description"],
        count: json["count"],
        url: json["url"],
        thumbnail: json["thumbnail"],
        thumbnailId: json["thumbnail_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "description": description,
        "count": count,
        "url": url,
        "thumbnail": thumbnail,
        "thumbnail_id": thumbnailId,
    };
}

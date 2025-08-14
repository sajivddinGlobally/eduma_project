// To parse this JSON data, do
//
//     final wishlistBodyModel = wishlistBodyModelFromJson(jsonString);

import 'dart:convert';

WishlistBodyModel wishlistBodyModelFromJson(String str) => WishlistBodyModel.fromJson(json.decode(str));

String wishlistBodyModelToJson(WishlistBodyModel data) => json.encode(data.toJson());

class WishlistBodyModel {
    int courseId;
    int userId;

    WishlistBodyModel({
        required this.courseId,
        required this.userId,
    });

    factory WishlistBodyModel.fromJson(Map<String, dynamic> json) => WishlistBodyModel(
        courseId: json["course_id"],
        userId: json["user_id"],
    );

    Map<String, dynamic> toJson() => {
        "course_id": courseId,
        "user_id": userId,
    };
}

// To parse this JSON data, do
//
//     final wishlistResModel = wishlistResModelFromJson(jsonString);

import 'dart:convert';

WishlistResModel wishlistResModelFromJson(String str) => WishlistResModel.fromJson(json.decode(str));

String wishlistResModelToJson(WishlistResModel data) => json.encode(data.toJson());

class WishlistResModel {
    String message;

    WishlistResModel({
        required this.message,
    });

    factory WishlistResModel.fromJson(Map<String, dynamic> json) => WishlistResModel(
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
    };
}

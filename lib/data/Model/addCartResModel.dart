// To parse this JSON data, do
//
//     final productAddCartResModel = productAddCartResModelFromJson(jsonString);

import 'dart:convert';

ProductAddCartResModel productAddCartResModelFromJson(String str) => ProductAddCartResModel.fromJson(json.decode(str));

String productAddCartResModelToJson(ProductAddCartResModel data) => json.encode(data.toJson());

class ProductAddCartResModel {
    bool success;
    String message;
    int cartCount;

    ProductAddCartResModel({
        required this.success,
        required this.message,
        required this.cartCount,
    });

    factory ProductAddCartResModel.fromJson(Map<String, dynamic> json) => ProductAddCartResModel(
        success: json["success"],
        message: json["message"],
        cartCount: json["cart_count"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "cart_count": cartCount,
    };
}

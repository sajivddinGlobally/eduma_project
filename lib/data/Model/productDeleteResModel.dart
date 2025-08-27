// To parse this JSON data, do
//
//     final productDeleteResModel = productDeleteResModelFromJson(jsonString);

import 'dart:convert';

ProductDeleteResModel productDeleteResModelFromJson(String str) => ProductDeleteResModel.fromJson(json.decode(str));

String productDeleteResModelToJson(ProductDeleteResModel data) => json.encode(data.toJson());

class ProductDeleteResModel {
    bool success;
    String message;
    Data data;

    ProductDeleteResModel({
        required this.success,
        required this.message,
        required this.data,
    });

    factory ProductDeleteResModel.fromJson(Map<String, dynamic> json) => ProductDeleteResModel(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    int productId;
    String productName;
    int wishlistCount;

    Data({
        required this.productId,
        required this.productName,
        required this.wishlistCount,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        productId: json["product_id"],
        productName: json["product_name"],
        wishlistCount: json["wishlist_count"],
    );

    Map<String, dynamic> toJson() => {
        "product_id": productId,
        "product_name": productName,
        "wishlist_count": wishlistCount,
    };
}

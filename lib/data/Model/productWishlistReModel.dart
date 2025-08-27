// To parse this JSON data, do
//
//     final productWishlistReModel = productWishlistReModelFromJson(jsonString);

import 'dart:convert';

ProductWishlistReModel productWishlistReModelFromJson(String str) => ProductWishlistReModel.fromJson(json.decode(str));

String productWishlistReModelToJson(ProductWishlistReModel data) => json.encode(data.toJson());

class ProductWishlistReModel {
    bool success;
    String message;
    Data data;

    ProductWishlistReModel({
        required this.success,
        required this.message,
        required this.data,
    });

    factory ProductWishlistReModel.fromJson(Map<String, dynamic> json) => ProductWishlistReModel(
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

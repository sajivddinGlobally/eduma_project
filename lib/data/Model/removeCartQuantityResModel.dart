// To parse this JSON data, do
//
//     final removeCartQuantityResModel = removeCartQuantityResModelFromJson(jsonString);

import 'dart:convert';

RemoveCartQuantityResModel removeCartQuantityResModelFromJson(String str) => RemoveCartQuantityResModel.fromJson(json.decode(str));

String removeCartQuantityResModelToJson(RemoveCartQuantityResModel data) => json.encode(data.toJson());

class RemoveCartQuantityResModel {
    bool success;
    String message;
    int cartCount;
    int remainingQuantity;

    RemoveCartQuantityResModel({
        required this.success,
        required this.message,
        required this.cartCount,
        required this.remainingQuantity,
    });

    factory RemoveCartQuantityResModel.fromJson(Map<String, dynamic> json) => RemoveCartQuantityResModel(
        success: json["success"],
        message: json["message"],
        cartCount: json["cart_count"],
        remainingQuantity: json["remaining_quantity"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "cart_count": cartCount,
        "remaining_quantity": remainingQuantity,
    };
}

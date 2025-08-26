// To parse this JSON data, do
//
//     final carRemoveResModel = carRemoveResModelFromJson(jsonString);

import 'dart:convert';

CarRemoveResModel carRemoveResModelFromJson(String str) => CarRemoveResModel.fromJson(json.decode(str));

String carRemoveResModelToJson(CarRemoveResModel data) => json.encode(data.toJson());

class CarRemoveResModel {
    bool success;
    String message;
    int cartCount;

    CarRemoveResModel({
        required this.success,
        required this.message,
        required this.cartCount,
    });

    factory CarRemoveResModel.fromJson(Map<String, dynamic> json) => CarRemoveResModel(
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

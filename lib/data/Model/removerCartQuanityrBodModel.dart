// To parse this JSON data, do
//
//     final removeCartQuantityBodyModel = removeCartQuantityBodyModelFromJson(jsonString);

import 'dart:convert';

RemoveCartQuantityBodyModel removeCartQuantityBodyModelFromJson(String str) => RemoveCartQuantityBodyModel.fromJson(json.decode(str));

String removeCartQuantityBodyModelToJson(RemoveCartQuantityBodyModel data) => json.encode(data.toJson());

class RemoveCartQuantityBodyModel {
    int productId;

    RemoveCartQuantityBodyModel({
        required this.productId,
    });

    factory RemoveCartQuantityBodyModel.fromJson(Map<String, dynamic> json) => RemoveCartQuantityBodyModel(
        productId: json["product_id"],
    );

    Map<String, dynamic> toJson() => {
        "product_id": productId,
    };
}

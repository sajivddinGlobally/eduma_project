// To parse this JSON data, do
//
//     final carRemoveBodyModel = carRemoveBodyModelFromJson(jsonString);

import 'dart:convert';

CarRemoveBodyModel carRemoveBodyModelFromJson(String str) => CarRemoveBodyModel.fromJson(json.decode(str));

String carRemoveBodyModelToJson(CarRemoveBodyModel data) => json.encode(data.toJson());

class CarRemoveBodyModel {
    int productId;

    CarRemoveBodyModel({
        required this.productId,
    });

    factory CarRemoveBodyModel.fromJson(Map<String, dynamic> json) => CarRemoveBodyModel(
        productId: json["product_id"],
    );

    Map<String, dynamic> toJson() => {
        "product_id": productId,
    };
}

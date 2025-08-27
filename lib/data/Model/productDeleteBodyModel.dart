// To parse this JSON data, do
//
//     final productDeleteBodyModel = productDeleteBodyModelFromJson(jsonString);

import 'dart:convert';

ProductDeleteBodyModel productDeleteBodyModelFromJson(String str) => ProductDeleteBodyModel.fromJson(json.decode(str));

String productDeleteBodyModelToJson(ProductDeleteBodyModel data) => json.encode(data.toJson());

class ProductDeleteBodyModel {
    int productId;

    ProductDeleteBodyModel({
        required this.productId,
    });

    factory ProductDeleteBodyModel.fromJson(Map<String, dynamic> json) => ProductDeleteBodyModel(
        productId: json["product_id"],
    );

    Map<String, dynamic> toJson() => {
        "product_id": productId,
    };
}

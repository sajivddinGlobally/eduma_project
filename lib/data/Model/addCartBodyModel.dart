// To parse this JSON data, do
//
//     final productAddCartBodyModel = productAddCartBodyModelFromJson(jsonString);

import 'dart:convert';

ProductAddCartBodyModel productAddCartBodyModelFromJson(String str) => ProductAddCartBodyModel.fromJson(json.decode(str));

String productAddCartBodyModelToJson(ProductAddCartBodyModel data) => json.encode(data.toJson());

class ProductAddCartBodyModel {
    int productId;
    int quantity;

    ProductAddCartBodyModel({
        required this.productId,
        required this.quantity,
    });

    factory ProductAddCartBodyModel.fromJson(Map<String, dynamic> json) => ProductAddCartBodyModel(
        productId: json["product_id"],
        quantity: json["quantity"],
    );

    Map<String, dynamic> toJson() => {
        "product_id": productId,
        "quantity": quantity,
    };
}

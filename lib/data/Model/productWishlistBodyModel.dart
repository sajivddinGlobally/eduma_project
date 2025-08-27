// To parse this JSON data, do
//
//     final productWishlistBodyModel = productWishlistBodyModelFromJson(jsonString);

import 'dart:convert';

ProductWishlistBodyModel productWishlistBodyModelFromJson(String str) => ProductWishlistBodyModel.fromJson(json.decode(str));

String productWishlistBodyModelToJson(ProductWishlistBodyModel data) => json.encode(data.toJson());

class ProductWishlistBodyModel {
    int productId;

    ProductWishlistBodyModel({
        required this.productId,
    });

    factory ProductWishlistBodyModel.fromJson(Map<String, dynamic> json) => ProductWishlistBodyModel(
        productId: json["product_id"],
    );

    Map<String, dynamic> toJson() => {
        "product_id": productId,
    };
}

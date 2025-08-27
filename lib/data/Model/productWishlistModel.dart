// To parse this JSON data, do
//
//     final productWishlistgetModel = productWishlistgetModelFromJson(jsonString);

import 'dart:convert';

ProductWishlistgetModel productWishlistgetModelFromJson(String str) => ProductWishlistgetModel.fromJson(json.decode(str));

String productWishlistgetModelToJson(ProductWishlistgetModel data) => json.encode(data.toJson());

class ProductWishlistgetModel {
    bool success;
    List<Datum> data;
    int count;

    ProductWishlistgetModel({
        required this.success,
        required this.data,
        required this.count,
    });

    factory ProductWishlistgetModel.fromJson(Map<String, dynamic> json) => ProductWishlistgetModel(
        success: json["success"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        count: json["count"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "count": count,
    };
}

class Datum {
    int id;
    String name;
    String price;
    String regularPrice;
    String salePrice;
    String image;
    String permalink;
    bool inStock;
    DateTime dateAdded;

    Datum({
        required this.id,
        required this.name,
        required this.price,
        required this.regularPrice,
        required this.salePrice,
        required this.image,
        required this.permalink,
        required this.inStock,
        required this.dateAdded,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        regularPrice: json["regular_price"],
        salePrice: json["sale_price"],
        image: json["image"],
        permalink: json["permalink"],
        inStock: json["in_stock"],
        dateAdded: DateTime.parse(json["date_added"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "regular_price": regularPrice,
        "sale_price": salePrice,
        "image": image,
        "permalink": permalink,
        "in_stock": inStock,
        "date_added": dateAdded.toIso8601String(),
    };
}

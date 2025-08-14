// To parse this JSON data, do
//
//     final getwishlistModel = getwishlistModelFromJson(jsonString);

import 'dart:convert';

GetwishlistModel getwishlistModelFromJson(String str) => GetwishlistModel.fromJson(json.decode(str));

String getwishlistModelToJson(GetwishlistModel data) => json.encode(data.toJson());

class GetwishlistModel {
    int total;
    List<Item> items;

    GetwishlistModel({
        required this.total,
        required this.items,
    });

    factory GetwishlistModel.fromJson(Map<String, dynamic> json) => GetwishlistModel(
        total: json["total"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
    };
}

class Item {
    int id;
    String type;
    String name;
    String price;
    String thumbnail;

    Item({
        required this.id,
        required this.type,
        required this.name,
        required this.price,
        required this.thumbnail,
    });

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        type: json["type"],
        name: json["name"],
        price: json["price"],
        thumbnail: json["thumbnail"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "name": name,
        "price": price,
        "thumbnail": thumbnail,
    };
}

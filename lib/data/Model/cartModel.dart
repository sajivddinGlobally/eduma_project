// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);

import 'dart:convert';

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));

String cartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
    List<Item> items;
    int subtotal;
    int count;

    CartModel({
        required this.items,
        required this.subtotal,
        required this.count,
    });

    factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        subtotal: json["subtotal"],
        count: json["count"],
    );

    Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "subtotal": subtotal,
        "count": count,
    };
}

class Item {
    int productId;
    int quantity;
    String name;
    String sku;
    int price;
    int total;
    String thumbnail;
    List<dynamic> variation;

    Item({
        required this.productId,
        required this.quantity,
        required this.name,
        required this.sku,
        required this.price,
        required this.total,
        required this.thumbnail,
        required this.variation,
    });

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        productId: json["product_id"],
        quantity: json["quantity"],
        name: json["name"],
        sku: json["sku"],
        price: json["price"],
        total: json["total"],
        thumbnail: json["thumbnail"],
        variation: List<dynamic>.from(json["variation"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "product_id": productId,
        "quantity": quantity,
        "name": name,
        "sku": sku,
        "price": price,
        "total": total,
        "thumbnail": thumbnail,
        "variation": List<dynamic>.from(variation.map((x) => x)),
    };
}

// To parse this JSON data, do
//
//     final relatedProductModel = relatedProductModelFromJson(jsonString);

import 'dart:convert';

List<RelatedProductModel> relatedProductModelFromJson(String str) => List<RelatedProductModel>.from(json.decode(str).map((x) => RelatedProductModel.fromJson(x)));

String relatedProductModelToJson(List<RelatedProductModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RelatedProductModel {
    int id;
    String name;
    String price;
    String image;
    String link;

    RelatedProductModel({
        required this.id,
        required this.name,
        required this.price,
        required this.image,
        required this.link,
    });

    factory RelatedProductModel.fromJson(Map<String, dynamic> json) => RelatedProductModel(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        image: json["image"],
        link: json["link"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "image": image,
        "link": link,
    };
}

// To parse this JSON data, do
//
//     final productInstrumentModel = productInstrumentModelFromJson(jsonString);

import 'dart:convert';

List<ProductInstrumentModel> productInstrumentModelFromJson(String str) => List<ProductInstrumentModel>.from(json.decode(str).map((x) => ProductInstrumentModel.fromJson(x)));

String productInstrumentModelToJson(List<ProductInstrumentModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductInstrumentModel {
    int id;
    String name;
    String slug;
    String sku;
    Type type;
    String price;
    String regularPrice;
    String salePrice;
    StockStatus stockStatus;
    dynamic stockQty;
    String shortDesc;
    String description;
    String image;
    List<String> gallery;
    List<dynamic> attributes;
    List<dynamic> variations;
    String link;

    ProductInstrumentModel({
        required this.id,
        required this.name,
        required this.slug,
        required this.sku,
        required this.type,
        required this.price,
        required this.regularPrice,
        required this.salePrice,
        required this.stockStatus,
        required this.stockQty,
        required this.shortDesc,
        required this.description,
        required this.image,
        required this.gallery,
        required this.attributes,
        required this.variations,
        required this.link,
    });

    factory ProductInstrumentModel.fromJson(Map<String, dynamic> json) => ProductInstrumentModel(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        sku: json["sku"],
        type: typeValues.map[json["type"]]!,
        price: json["price"],
        regularPrice: json["regular_price"],
        salePrice: json["sale_price"],
        stockStatus: stockStatusValues.map[json["stock_status"]]!,
        stockQty: json["stock_qty"],
        shortDesc: json["short_desc"],
        description: json["description"],
        image: json["image"],
        gallery: List<String>.from(json["gallery"].map((x) => x)),
        attributes: List<dynamic>.from(json["attributes"].map((x) => x)),
        variations: List<dynamic>.from(json["variations"].map((x) => x)),
        link: json["link"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "sku": sku,
        "type": typeValues.reverse[type],
        "price": price,
        "regular_price": regularPrice,
        "sale_price": salePrice,
        "stock_status": stockStatusValues.reverse[stockStatus],
        "stock_qty": stockQty,
        "short_desc": shortDesc,
        "description": description,
        "image": image,
        "gallery": List<dynamic>.from(gallery.map((x) => x)),
        "attributes": List<dynamic>.from(attributes.map((x) => x)),
        "variations": List<dynamic>.from(variations.map((x) => x)),
        "link": link,
    };
}

enum StockStatus {
    INSTOCK
}

final stockStatusValues = EnumValues({
    "instock": StockStatus.INSTOCK
});

enum Type {
    SIMPLE
}

final typeValues = EnumValues({
    "simple": Type.SIMPLE
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}

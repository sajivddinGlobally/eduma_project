// To parse this JSON data, do
//
//     final productBookModel = productBookModelFromJson(jsonString);

import 'dart:convert';

List<ProductBookModel> productBookModelFromJson(String str) => List<ProductBookModel>.from(json.decode(str).map((x) => ProductBookModel.fromJson(x)));

String productBookModelToJson(List<ProductBookModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductBookModel {
    int id;
    String name;
    String slug;
    String sku;
    Type type;
    String price;
    String regularPrice;
    String salePrice;
    StockStatus stockStatus;
    int? stockQty;
    String shortDesc;
    String description;
    String image;
    List<String> gallery;
    dynamic attributes;
    List<Variation> variations;
    String link;

    ProductBookModel({
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

    factory ProductBookModel.fromJson(Map<String, dynamic> json) => ProductBookModel(
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
        attributes: json["attributes"],
        variations: List<Variation>.from(json["variations"].map((x) => Variation.fromJson(x))),
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
        "attributes": attributes,
        "variations": List<dynamic>.from(variations.map((x) => x.toJson())),
        "link": link,
    };
}

class AttributesAttributes {
    List<int> paLanguage;

    AttributesAttributes({
        required this.paLanguage,
    });

    factory AttributesAttributes.fromJson(Map<String, dynamic> json) => AttributesAttributes(
        paLanguage: List<int>.from(json["pa_language"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "pa_language": List<dynamic>.from(paLanguage.map((x) => x)),
    };
}

enum StockStatus {
    INSTOCK
}

final stockStatusValues = EnumValues({
    "instock": StockStatus.INSTOCK
});

enum Type {
    SIMPLE,
    VARIABLE
}

final typeValues = EnumValues({
    "simple": Type.SIMPLE,
    "variable": Type.VARIABLE
});

class Variation {
    int id;
    int price;
    VariationAttributes attributes;
    String image;

    Variation({
        required this.id,
        required this.price,
        required this.attributes,
        required this.image,
    });

    factory Variation.fromJson(Map<String, dynamic> json) => Variation(
        id: json["id"],
        price: json["price"],
        attributes: VariationAttributes.fromJson(json["attributes"]),
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
        "attributes": attributes.toJson(),
        "image": image,
    };
}

class VariationAttributes {
    AttributePaLanguage attributePaLanguage;

    VariationAttributes({
        required this.attributePaLanguage,
    });

    factory VariationAttributes.fromJson(Map<String, dynamic> json) => VariationAttributes(
        attributePaLanguage: attributePaLanguageValues.map[json["attribute_pa_language"]]!,
    );

    Map<String, dynamic> toJson() => {
        "attribute_pa_language": attributePaLanguageValues.reverse[attributePaLanguage],
    };
}

enum AttributePaLanguage {
    BILINGUAL,
    ENGLISH,
    HINDI
}

final attributePaLanguageValues = EnumValues({
    "bilingual": AttributePaLanguage.BILINGUAL,
    "english": AttributePaLanguage.ENGLISH,
    "hindi": AttributePaLanguage.HINDI
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

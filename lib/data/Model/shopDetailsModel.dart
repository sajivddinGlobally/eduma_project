// To parse this JSON data, do
//
//     final shopDetailsModel = shopDetailsModelFromJson(jsonString);

import 'dart:convert';

ShopDetailsModel shopDetailsModelFromJson(String str) => ShopDetailsModel.fromJson(json.decode(str));

String shopDetailsModelToJson(ShopDetailsModel data) => json.encode(data.toJson());

class ShopDetailsModel {
    int id;
    String name;
    String slug;
    String sku;
    String type;
    String price;
    String regularPrice;
    String salePrice;
    String stockStatus;
    dynamic stockQty;
    String weight;
    Dimensions dimensions;
    String shortDesc;
    String description;
    String image;
    List<String> gallery;
    List<dynamic> attributes;
    List<dynamic> variations;
    List<Category> categories;
    List<dynamic> tags;
    List<Related> related;
    List<dynamic> upsells;
    List<dynamic> crossSells;
    List<dynamic> downloads;
    String link;
    String averageRating;
    int reviewCount;

    ShopDetailsModel({
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
        required this.weight,
        required this.dimensions,
        required this.shortDesc,
        required this.description,
        required this.image,
        required this.gallery,
        required this.attributes,
        required this.variations,
        required this.categories,
        required this.tags,
        required this.related,
        required this.upsells,
        required this.crossSells,
        required this.downloads,
        required this.link,
        required this.averageRating,
        required this.reviewCount,
    });

    factory ShopDetailsModel.fromJson(Map<String, dynamic> json) => ShopDetailsModel(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        sku: json["sku"],
        type: json["type"],
        price: json["price"],
        regularPrice: json["regular_price"],
        salePrice: json["sale_price"],
        stockStatus: json["stock_status"],
        stockQty: json["stock_qty"],
        weight: json["weight"],
        dimensions: Dimensions.fromJson(json["dimensions"]),
        shortDesc: json["short_desc"],
        description: json["description"],
        image: json["image"],
        gallery: List<String>.from(json["gallery"].map((x) => x)),
        attributes: List<dynamic>.from(json["attributes"].map((x) => x)),
        variations: List<dynamic>.from(json["variations"].map((x) => x)),
        categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
        tags: List<dynamic>.from(json["tags"].map((x) => x)),
        related: List<Related>.from(json["related"].map((x) => Related.fromJson(x))),
        upsells: List<dynamic>.from(json["upsells"].map((x) => x)),
        crossSells: List<dynamic>.from(json["cross_sells"].map((x) => x)),
        downloads: List<dynamic>.from(json["downloads"].map((x) => x)),
        link: json["link"],
        averageRating: json["average_rating"],
        reviewCount: json["review_count"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "sku": sku,
        "type": type,
        "price": price,
        "regular_price": regularPrice,
        "sale_price": salePrice,
        "stock_status": stockStatus,
        "stock_qty": stockQty,
        "weight": weight,
        "dimensions": dimensions.toJson(),
        "short_desc": shortDesc,
        "description": description,
        "image": image,
        "gallery": List<dynamic>.from(gallery.map((x) => x)),
        "attributes": List<dynamic>.from(attributes.map((x) => x)),
        "variations": List<dynamic>.from(variations.map((x) => x)),
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "related": List<dynamic>.from(related.map((x) => x.toJson())),
        "upsells": List<dynamic>.from(upsells.map((x) => x)),
        "cross_sells": List<dynamic>.from(crossSells.map((x) => x)),
        "downloads": List<dynamic>.from(downloads.map((x) => x)),
        "link": link,
        "average_rating": averageRating,
        "review_count": reviewCount,
    };
}

class Category {
    int id;
    String name;
    String slug;

    Category({
        required this.id,
        required this.name,
        required this.slug,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
    };
}

class Dimensions {
    String length;
    String width;
    String height;

    Dimensions({
        required this.length,
        required this.width,
        required this.height,
    });

    factory Dimensions.fromJson(Map<String, dynamic> json) => Dimensions(
        length: json["length"],
        width: json["width"],
        height: json["height"],
    );

    Map<String, dynamic> toJson() => {
        "length": length,
        "width": width,
        "height": height,
    };
}

class Related {
    int id;
    String name;
    String price;
    String link;

    Related({
        required this.id,
        required this.name,
        required this.price,
        required this.link,
    });

    factory Related.fromJson(Map<String, dynamic> json) => Related(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        link: json["link"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "link": link,
    };
}

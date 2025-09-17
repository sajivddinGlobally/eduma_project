// To parse this JSON data, do
//
//     final productListModel = productListModelFromJson(jsonString);

import 'dart:convert';

List<ProductListModel> productListModelFromJson(String str) =>
    List<ProductListModel>.from(
        json.decode(str).map((x) => ProductListModel.fromJson(x)));

String productListModelToJson(List<ProductListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductListModel {
  int? id;
  String? name;
  String? slug;
  String? permalink;
  String? dateCreated;
  String? dateModified;
  String? type;
  String? status;
  bool? featured;
  String? catalogVisibility;
  String? description;
  String? shortDescription;
  String? sku;
  String? price;
  String? regularPrice;
  String? salePrice;
  String? dateOnSaleFrom;
  String? dateOnSaleTo;
  bool? onSale;
  bool? purchasable;
  int? totalSales;
  bool? virtual;
  bool? downloadable;
  List<dynamic>? downloads;
  int? downloadLimit;
  int? downloadExpiry;
  String? externalUrl;
  String? buttonText;
  String? taxStatus;
  String? taxClass;
  bool? manageStock;
  int? stockQuantity;
  String? backorders;
  bool? backordersAllowed;
  bool? backordered;
  bool? soldIndividually;
  String? weight;
  Dimensions? dimensions;
  bool? shippingRequired;
  bool? shippingTaxable;
  String? shippingClass;
  int? shippingClassId;
  bool? reviewsAllowed;
  String? averageRating;
  int? ratingCount;
  List<dynamic>? relatedIds;
  List<dynamic>? upsellIds;
  List<dynamic>? crossSellIds;
  int? parentId;
  String? purchaseNote;
  List<Category>? categories;
  List<ImageModel>? images;

  ProductListModel({
    this.id,
    this.name,
    this.slug,
    this.permalink,
    this.dateCreated,
    this.dateModified,
    this.type,
    this.status,
    this.featured,
    this.catalogVisibility,
    this.description,
    this.shortDescription,
    this.sku,
    this.price,
    this.regularPrice,
    this.salePrice,
    this.dateOnSaleFrom,
    this.dateOnSaleTo,
    this.onSale,
    this.purchasable,
    this.totalSales,
    this.virtual,
    this.downloadable,
    this.downloads,
    this.downloadLimit,
    this.downloadExpiry,
    this.externalUrl,
    this.buttonText,
    this.taxStatus,
    this.taxClass,
    this.manageStock,
    this.stockQuantity,
    this.backorders,
    this.backordersAllowed,
    this.backordered,
    this.soldIndividually,
    this.weight,
    this.dimensions,
    this.shippingRequired,
    this.shippingTaxable,
    this.shippingClass,
    this.shippingClassId,
    this.reviewsAllowed,
    this.averageRating,
    this.ratingCount,
    this.relatedIds,
    this.upsellIds,
    this.crossSellIds,
    this.parentId,
    this.purchaseNote,
    this.categories,
    this.images,
  });

  factory ProductListModel.fromJson(Map<String, dynamic> json) =>
      ProductListModel(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        permalink: json["permalink"],
        dateCreated: json["date_created"],
        dateModified: json["date_modified"],
        type: json["type"],
        status: json["status"],
        featured: json["featured"],
        catalogVisibility: json["catalog_visibility"],
        description: json["description"],
        shortDescription: json["short_description"],
        sku: json["sku"],
        price: json["price"],
        regularPrice: json["regular_price"],
        salePrice: json["sale_price"],
        dateOnSaleFrom: json["date_on_sale_from"],
        dateOnSaleTo: json["date_on_sale_to"],
        onSale: json["on_sale"],
        purchasable: json["purchasable"],
        totalSales: json["total_sales"],
        virtual: json["virtual"],
        downloadable: json["downloadable"],
        downloads: json["downloads"] != null
            ? List<dynamic>.from(json["downloads"].map((x) => x))
            : [],
        downloadLimit: json["download_limit"],
        downloadExpiry: json["download_expiry"],
        externalUrl: json["external_url"],
        buttonText: json["button_text"],
        taxStatus: json["tax_status"],
        taxClass: json["tax_class"],
        manageStock: json["manage_stock"],
        stockQuantity: json["stock_quantity"],
        backorders: json["backorders"],
        backordersAllowed: json["backorders_allowed"],
        backordered: json["backordered"],
        soldIndividually: json["sold_individually"],
        weight: json["weight"],
        dimensions: json["dimensions"] != null
            ? Dimensions.fromJson(json["dimensions"])
            : null,
        shippingRequired: json["shipping_required"],
        shippingTaxable: json["shipping_taxable"],
        shippingClass: json["shipping_class"],
        shippingClassId: json["shipping_class_id"],
        reviewsAllowed: json["reviews_allowed"],
        averageRating: json["average_rating"],
        ratingCount: json["rating_count"],
        relatedIds: json["related_ids"] != null
            ? List<dynamic>.from(json["related_ids"].map((x) => x))
            : [],
        upsellIds: json["upsell_ids"] != null
            ? List<dynamic>.from(json["upsell_ids"].map((x) => x))
            : [],
        crossSellIds: json["cross_sell_ids"] != null
            ? List<dynamic>.from(json["cross_sell_ids"].map((x) => x))
            : [],
        parentId: json["parent_id"],
        purchaseNote: json["purchase_note"],
        categories: json["categories"] != null
            ? List<Category>.from(
                json["categories"].map((x) => Category.fromJson(x)))
            : [],
        images: json["images"] != null
            ? List<ImageModel>.from(
                json["images"].map((x) => ImageModel.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "permalink": permalink,
        "date_created": dateCreated,
        "date_modified": dateModified,
        "type": type,
        "status": status,
        "featured": featured,
        "catalog_visibility": catalogVisibility,
        "description": description,
        "short_description": shortDescription,
        "sku": sku,
        "price": price,
        "regular_price": regularPrice,
        "sale_price": salePrice,
        "date_on_sale_from": dateOnSaleFrom,
        "date_on_sale_to": dateOnSaleTo,
        "on_sale": onSale,
        "purchasable": purchasable,
        "total_sales": totalSales,
        "virtual": virtual,
        "downloadable": downloadable,
        "downloads": downloads,
        "download_limit": downloadLimit,
        "download_expiry": downloadExpiry,
        "external_url": externalUrl,
        "button_text": buttonText,
        "tax_status": taxStatus,
        "tax_class": taxClass,
        "manage_stock": manageStock,
        "stock_quantity": stockQuantity,
        "backorders": backorders,
        "backorders_allowed": backordersAllowed,
        "backordered": backordered,
        "sold_individually": soldIndividually,
        "weight": weight,
        "dimensions": dimensions?.toJson(),
        "shipping_required": shippingRequired,
        "shipping_taxable": shippingTaxable,
        "shipping_class": shippingClass,
        "shipping_class_id": shippingClassId,
        "reviews_allowed": reviewsAllowed,
        "average_rating": averageRating,
        "rating_count": ratingCount,
        "related_ids": relatedIds,
        "upsell_ids": upsellIds,
        "cross_sell_ids": crossSellIds,
        "parent_id": parentId,
        "purchase_note": purchaseNote,
        "categories": categories?.map((x) => x.toJson()).toList(),
        "images": images?.map((x) => x.toJson()).toList(),
      };
}

class Dimensions {
  String? length;
  String? width;
  String? height;

  Dimensions({
    this.length,
    this.width,
    this.height,
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

class Category {
  int? id;
  String? name;
  String? slug;

  Category({
    this.id,
    this.name,
    this.slug,
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

class ImageModel {
  int? id;
  String? src;
  String? name;
  String? alt;
  String? medium;

  ImageModel({
    this.id,
    this.src,
    this.name,
    this.alt,
    this.medium,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        id: json["id"],
        src: json["src"],
        name: json["name"],
        alt: json["alt"],
        medium: json["medium"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "src": src,
        "name": name,
        "alt": alt,
        "medium": medium,
      };
}

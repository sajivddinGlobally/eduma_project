// To parse this JSON data, do
//
//     final variationResModel = variationResModelFromJson(jsonString);

import 'dart:convert';

List<VariationResModel> variationResModelFromJson(String str) =>
    List<VariationResModel>.from(
      json.decode(str).map((x) => VariationResModel.fromJson(x)),
    );

String variationResModelToJson(List<VariationResModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VariationResModel {
  int id;
  String type;
  DateTime dateCreated;
  DateTime dateCreatedGmt;
  DateTime dateModified;
  DateTime dateModifiedGmt;
  String description;
  String permalink;
  String sku;
  String globalUniqueId;
  String price;
  String regularPrice;
  String salePrice;
  dynamic dateOnSaleFrom;
  dynamic dateOnSaleFromGmt;
  dynamic dateOnSaleTo;
  dynamic dateOnSaleToGmt;
  bool onSale;
  String status;
  bool purchasable;
  bool virtual;
  bool downloadable;
  List<dynamic> downloads;
  int downloadLimit;
  int downloadExpiry;
  String taxStatus;
  String taxClass;
  String? manageStock;
  String? stockQuantity;
  String stockStatus;
  String backorders;
  bool backordersAllowed;
  bool backordered;
  dynamic lowStockAmount;
  String weight;
  Dimensions dimensions;
  String shippingClass;
  int shippingClassId;
  Image image;
  List<Attribute> attributes;
  int menuOrder;
  List<dynamic> metaData;
  String name;
  int parentId;
  List<dynamic> amsProductPointsReward;
  int amsPriceToDisplay;
  String featuredImageSrc;
  List<dynamic> amsAcf;
  Links links;

  VariationResModel({
    required this.id,
    required this.type,
    required this.dateCreated,
    required this.dateCreatedGmt,
    required this.dateModified,
    required this.dateModifiedGmt,
    required this.description,
    required this.permalink,
    required this.sku,
    required this.globalUniqueId,
    required this.price,
    required this.regularPrice,
    required this.salePrice,
    required this.dateOnSaleFrom,
    required this.dateOnSaleFromGmt,
    required this.dateOnSaleTo,
    required this.dateOnSaleToGmt,
    required this.onSale,
    required this.status,
    required this.purchasable,
    required this.virtual,
    required this.downloadable,
    required this.downloads,
    required this.downloadLimit,
    required this.downloadExpiry,
    required this.taxStatus,
    required this.taxClass,
    this.manageStock,
    this.stockQuantity,
    required this.stockStatus,
    required this.backorders,
    required this.backordersAllowed,
    required this.backordered,
    required this.lowStockAmount,
    required this.weight,
    required this.dimensions,
    required this.shippingClass,
    required this.shippingClassId,
    required this.image,
    required this.attributes,
    required this.menuOrder,
    required this.metaData,
    required this.name,
    required this.parentId,
    required this.amsProductPointsReward,
    required this.amsPriceToDisplay,
    required this.featuredImageSrc,
    required this.amsAcf,
    required this.links,
  });

  factory VariationResModel.fromJson(Map<String, dynamic> json) =>
      VariationResModel(
        id: json["id"],
        type: json["type"],
        //dateCreated: DateTime.parse(json["date_created"]),
        dateCreated: json["date_created"] != null && json["date_created"] != ""
            ? DateTime.parse(json["date_created"])
            : DateTime.now(),
        dateCreatedGmt: DateTime.parse(json["date_created_gmt"]),
        dateModified: DateTime.parse(json["date_modified"]),
        dateModifiedGmt: DateTime.parse(json["date_modified_gmt"]),
        description: json["description"],
        permalink: json["permalink"],
        sku: json["sku"],
        globalUniqueId: json["global_unique_id"],
        price: json["price"],
        regularPrice: json["regular_price"],
        salePrice: json["sale_price"],
        dateOnSaleFrom: json["date_on_sale_from"],
        dateOnSaleFromGmt: json["date_on_sale_from_gmt"],
        dateOnSaleTo: json["date_on_sale_to"],
        dateOnSaleToGmt: json["date_on_sale_to_gmt"],
        onSale: json["on_sale"],
        status: json["status"],
        purchasable: json["purchasable"],
        virtual: json["virtual"],
        downloadable: json["downloadable"],
        downloads: List<dynamic>.from(json["downloads"].map((x) => x)),
        downloadLimit: json["download_limit"],
        downloadExpiry: json["download_expiry"],
        taxStatus: json["tax_status"],
        taxClass: json["tax_class"],
        manageStock: json["manage_stock"].toString() ?? "",
        stockQuantity: json["stock_quantity"] != null
            ? json["stock_quantity"].toString()
            : "0",
        stockStatus: json["stock_status"],
        backorders: json["backorders"],
        backordersAllowed: json["backorders_allowed"],
        backordered: json["backordered"],
        lowStockAmount: json["low_stock_amount"],
        weight: json["weight"],
        dimensions: Dimensions.fromJson(json["dimensions"]),
        shippingClass: json["shipping_class"],
        shippingClassId: json["shipping_class_id"],
        image: Image.fromJson(json["image"]),
        attributes: List<Attribute>.from(
          json["attributes"].map((x) => Attribute.fromJson(x)),
        ),
        menuOrder: json["menu_order"],
        metaData: List<dynamic>.from(json["meta_data"].map((x) => x)),
        name: json["name"],
        parentId: json["parent_id"],
        amsProductPointsReward: List<dynamic>.from(
          json["ams_product_points_reward"].map((x) => x),
        ),
        amsPriceToDisplay: json["ams_price_to_display"],
        featuredImageSrc: json["featured_image_src"],
        amsAcf: List<dynamic>.from(json["ams_acf"].map((x) => x)),
        links: Links.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "date_created": dateCreated.toIso8601String(),
    "date_created_gmt": dateCreatedGmt.toIso8601String(),
    "date_modified": dateModified.toIso8601String(),
    "date_modified_gmt": dateModifiedGmt.toIso8601String(),
    "description": description,
    "permalink": permalink,
    "sku": sku,
    "global_unique_id": globalUniqueId,
    "price": price,
    "regular_price": regularPrice,
    "sale_price": salePrice,
    "date_on_sale_from": dateOnSaleFrom,
    "date_on_sale_from_gmt": dateOnSaleFromGmt,
    "date_on_sale_to": dateOnSaleTo,
    "date_on_sale_to_gmt": dateOnSaleToGmt,
    "on_sale": onSale,
    "status": status,
    "purchasable": purchasable,
    "virtual": virtual,
    "downloadable": downloadable,
    "downloads": List<dynamic>.from(downloads.map((x) => x)),
    "download_limit": downloadLimit,
    "download_expiry": downloadExpiry,
    "tax_status": taxStatus,
    "tax_class": taxClass,
    "manage_stock": manageStock,
    "stock_quantity": stockQuantity,
    "stock_status": stockStatus,
    "backorders": backorders,
    "backorders_allowed": backordersAllowed,
    "backordered": backordered,
    "low_stock_amount": lowStockAmount,
    "weight": weight,
    "dimensions": dimensions.toJson(),
    "shipping_class": shippingClass,
    "shipping_class_id": shippingClassId,
    "image": image.toJson(),
    "attributes": List<dynamic>.from(attributes.map((x) => x.toJson())),
    "menu_order": menuOrder,
    "meta_data": List<dynamic>.from(metaData.map((x) => x)),
    "name": name,
    "parent_id": parentId,
    "ams_product_points_reward": List<dynamic>.from(
      amsProductPointsReward.map((x) => x),
    ),
    "ams_price_to_display": amsPriceToDisplay,
    "featured_image_src": featuredImageSrc,
    "ams_acf": List<dynamic>.from(amsAcf.map((x) => x)),
    "_links": links.toJson(),
  };
}

class Attribute {
  int id;
  String name;
  String slug;
  String option;

  Attribute({
    required this.id,
    required this.name,
    required this.slug,
    required this.option,
  });

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    option: json["option"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "option": option,
  };
}

class Dimensions {
  String length;
  String width;
  String height;

  Dimensions({required this.length, required this.width, required this.height});

  factory Dimensions.fromJson(Map<String, dynamic> json) => Dimensions(
    // length: json["length"],
    // width: json["width"],
    // height: json["height"],
    length: json["length"]?.toString() ?? "0",
    width: json["width"]?.toString() ?? "0",
    height: json["height"]?.toString() ?? "0",
  );

  Map<String, dynamic> toJson() => {
    "length": length,
    "width": width,
    "height": height,
  };
}

class Image {
  int id;
  DateTime dateCreated;
  DateTime dateCreatedGmt;
  DateTime dateModified;
  DateTime dateModifiedGmt;
  String src;
  String name;
  String alt;

  Image({
    required this.id,
    required this.dateCreated,
    required this.dateCreatedGmt,
    required this.dateModified,
    required this.dateModifiedGmt,
    required this.src,
    required this.name,
    required this.alt,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    id: json["id"],
    dateCreated: DateTime.parse(json["date_created"]),
    dateCreatedGmt: DateTime.parse(json["date_created_gmt"]),
    dateModified: DateTime.parse(json["date_modified"]),
    dateModifiedGmt: DateTime.parse(json["date_modified_gmt"]),
    // src: json["src"],
    src: json["src"] ?? "",
    name: json["name"],
    alt: json["alt"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date_created": dateCreated.toIso8601String(),
    "date_created_gmt": dateCreatedGmt.toIso8601String(),
    "date_modified": dateModified.toIso8601String(),
    "date_modified_gmt": dateModifiedGmt.toIso8601String(),
    "src": src,
    "name": name,
    "alt": alt,
  };
}

class Links {
  List<Self> self;
  List<Collection> collection;
  List<Collection> up;

  Links({required this.self, required this.collection, required this.up});

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    self: List<Self>.from(json["self"].map((x) => Self.fromJson(x))),
    collection: List<Collection>.from(
      json["collection"].map((x) => Collection.fromJson(x)),
    ),
    up: List<Collection>.from(json["up"].map((x) => Collection.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "self": List<dynamic>.from(self.map((x) => x.toJson())),
    "collection": List<dynamic>.from(collection.map((x) => x.toJson())),
    "up": List<dynamic>.from(up.map((x) => x.toJson())),
  };
}

class Collection {
  String href;

  Collection({required this.href});

  factory Collection.fromJson(Map<String, dynamic> json) =>
      Collection(href: json["href"]);

  Map<String, dynamic> toJson() => {"href": href};
}

class Self {
  String href;
  TargetHints targetHints;

  Self({required this.href, required this.targetHints});

  factory Self.fromJson(Map<String, dynamic> json) => Self(
    href: json["href"],
    targetHints: TargetHints.fromJson(json["targetHints"]),
  );

  Map<String, dynamic> toJson() => {
    "href": href,
    "targetHints": targetHints.toJson(),
  };
}

class TargetHints {
  List<String> allow;

  TargetHints({required this.allow});

  factory TargetHints.fromJson(Map<String, dynamic> json) =>
      TargetHints(allow: List<String>.from(json["allow"].map((x) => x)));

  Map<String, dynamic> toJson() => {
    "allow": List<dynamic>.from(allow.map((x) => x)),
  };
}

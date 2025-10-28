// // To parse this JSON data, do
// //
// //     final productDetailsModel = productDetailsModelFromJson(jsonString);

// import 'dart:convert';

// ProductDetailsModel productDetailsModelFromJson(String str) =>
//     ProductDetailsModel.fromJson(json.decode(str));

// String productDetailsModelToJson(ProductDetailsModel data) =>
//     json.encode(data.toJson());

// class ProductDetailsModel {
//   int id;
//   String name;
//   String slug;
//   String permalink;
//   DateTime dateCreated;
//   DateTime dateCreatedGmt;
//   DateTime dateModified;
//   DateTime dateModifiedGmt;
//   String type;
//   String status;
//   bool featured;
//   String catalogVisibility;
//   String description;
//   String shortDescription;
//   String sku;
//   String price;
//   String regularPrice;
//   String salePrice;
//   dynamic dateOnSaleFrom;
//   dynamic dateOnSaleFromGmt;
//   dynamic dateOnSaleTo;
//   dynamic dateOnSaleToGmt;
//   bool onSale;
//   bool purchasable;
//   int totalSales;
//   bool virtual;
//   bool downloadable;
//   List<dynamic> downloads;
//   int downloadLimit;
//   int downloadExpiry;
//   String externalUrl;
//   String buttonText;
//   String taxStatus;
//   String taxClass;
//   bool manageStock;
//   dynamic stockQuantity;
//   String backorders;
//   bool backordersAllowed;
//   bool backordered;
//   dynamic lowStockAmount;
//   bool soldIndividually;
//   String weight;
//   Dimensions dimensions;
//   bool shippingRequired;
//   bool shippingTaxable;
//   String shippingClass;
//   int shippingClassId;
//   bool reviewsAllowed;
//   String averageRating;
//   int ratingCount;
//   List<dynamic> upsellIds;
//   List<dynamic> crossSellIds;
//   int parentId;
//   String purchaseNote;
//   List<Category> categories;
//   List<dynamic> brands;
//   List<dynamic> tags;
//   List<Image> images;
//   List<dynamic> attributes;
//   List<dynamic> defaultAttributes;
//   List<dynamic> variations;
//   List<dynamic> groupedProducts;
//   int menuOrder;
//   String priceHtml;
//   List<int> relatedIds;
//   List<MetaDatum> metaData;
//   String stockStatus;
//   bool hasOptions;
//   String postPassword;
//   String globalUniqueId;
//   int? amsDefaultVariationId;
//   List<dynamic>? amsProductPointsReward;
//   double amsProductDiscountPercentage;
//   int amsPriceToDisplay;
//   List<dynamic> amsAcf;
//   ProductUnits productUnits;
//   WcfmProductPolicyData wcfmProductPolicyData;
//   bool showAdditionalInfoTab;
//   Store store;
//   String productRestirctionMessage;
//   Links links;

//   ProductDetailsModel({
//     required this.id,
//     required this.name,
//     required this.slug,
//     required this.permalink,
//     required this.dateCreated,
//     required this.dateCreatedGmt,
//     required this.dateModified,
//     required this.dateModifiedGmt,
//     required this.type,
//     required this.status,
//     required this.featured,
//     required this.catalogVisibility,
//     required this.description,
//     required this.shortDescription,
//     required this.sku,
//     required this.price,
//     required this.regularPrice,
//     required this.salePrice,
//     required this.dateOnSaleFrom,
//     required this.dateOnSaleFromGmt,
//     required this.dateOnSaleTo,
//     required this.dateOnSaleToGmt,
//     required this.onSale,
//     required this.purchasable,
//     required this.totalSales,
//     required this.virtual,
//     required this.downloadable,
//     required this.downloads,
//     required this.downloadLimit,
//     required this.downloadExpiry,
//     required this.externalUrl,
//     required this.buttonText,
//     required this.taxStatus,
//     required this.taxClass,
//     required this.manageStock,
//     required this.stockQuantity,
//     required this.backorders,
//     required this.backordersAllowed,
//     required this.backordered,
//     required this.lowStockAmount,
//     required this.soldIndividually,
//     required this.weight,
//     required this.dimensions,
//     required this.shippingRequired,
//     required this.shippingTaxable,
//     required this.shippingClass,
//     required this.shippingClassId,
//     required this.reviewsAllowed,
//     required this.averageRating,
//     required this.ratingCount,
//     required this.upsellIds,
//     required this.crossSellIds,
//     required this.parentId,
//     required this.purchaseNote,
//     required this.categories,
//     required this.brands,
//     required this.tags,
//     required this.images,
//     required this.attributes,
//     required this.defaultAttributes,
//     required this.variations,
//     required this.groupedProducts,
//     required this.menuOrder,
//     required this.priceHtml,
//     required this.relatedIds,
//     required this.metaData,
//     required this.stockStatus,
//     required this.hasOptions,
//     required this.postPassword,
//     required this.globalUniqueId,
//     required this.amsDefaultVariationId,
//     this.amsProductPointsReward,
//     required this.amsProductDiscountPercentage,
//     required this.amsPriceToDisplay,
//     required this.amsAcf,
//     required this.productUnits,
//     required this.wcfmProductPolicyData,
//     required this.showAdditionalInfoTab,
//     required this.store,
//     required this.productRestirctionMessage,
//     required this.links,
//   });

//   factory ProductDetailsModel.fromJson(
//     Map<String, dynamic> json,
//   ) => ProductDetailsModel(
//     id: json["id"],
//     name: json["name"],
//     slug: json["slug"],
//     permalink: json["permalink"],
//     dateCreated: DateTime.parse(json["date_created"]),
//     dateCreatedGmt: DateTime.parse(json["date_created_gmt"]),
//     dateModified: DateTime.parse(json["date_modified"]),
//     dateModifiedGmt: DateTime.parse(json["date_modified_gmt"]),
//     type: json["type"],
//     status: json["status"],
//     featured: json["featured"],
//     catalogVisibility: json["catalog_visibility"],
//     description: json["description"],
//     shortDescription: json["short_description"],
//     sku: json["sku"],
//     price: json["price"],
//     regularPrice: json["regular_price"],
//     salePrice: json["sale_price"],
//     dateOnSaleFrom: json["date_on_sale_from"],
//     dateOnSaleFromGmt: json["date_on_sale_from_gmt"],
//     dateOnSaleTo: json["date_on_sale_to"],
//     dateOnSaleToGmt: json["date_on_sale_to_gmt"],
//     onSale: json["on_sale"],
//     purchasable: json["purchasable"],
//     totalSales: json["total_sales"],
//     virtual: json["virtual"],
//     downloadable: json["downloadable"],
//     downloads: List<dynamic>.from(json["downloads"].map((x) => x)),
//     downloadLimit: json["download_limit"],
//     downloadExpiry: json["download_expiry"],
//     externalUrl: json["external_url"],
//     buttonText: json["button_text"],
//     taxStatus: json["tax_status"],
//     taxClass: json["tax_class"],
//     manageStock: json["manage_stock"],
//     stockQuantity: json["stock_quantity"],
//     backorders: json["backorders"],
//     backordersAllowed: json["backorders_allowed"],
//     backordered: json["backordered"],
//     lowStockAmount: json["low_stock_amount"],
//     soldIndividually: json["sold_individually"],
//     weight: json["weight"],
//     dimensions: Dimensions.fromJson(json["dimensions"]),
//     shippingRequired: json["shipping_required"],
//     shippingTaxable: json["shipping_taxable"],
//     shippingClass: json["shipping_class"],
//     shippingClassId: json["shipping_class_id"],
//     reviewsAllowed: json["reviews_allowed"],
//     averageRating: json["average_rating"],
//     ratingCount: json["rating_count"],
//     upsellIds: List<dynamic>.from(json["upsell_ids"].map((x) => x)),
//     crossSellIds: List<dynamic>.from(json["cross_sell_ids"].map((x) => x)),
//     parentId: json["parent_id"],
//     purchaseNote: json["purchase_note"],
//     categories: List<Category>.from(
//       json["categories"].map((x) => Category.fromJson(x)),
//     ),
//     brands: List<dynamic>.from(json["brands"].map((x) => x)),
//     tags: List<dynamic>.from(json["tags"].map((x) => x)),
//     images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
//     attributes: List<dynamic>.from(json["attributes"].map((x) => x)),
//     defaultAttributes: List<dynamic>.from(
//       json["default_attributes"].map((x) => x),
//     ),
//     variations: List<dynamic>.from(json["variations"].map((x) => x)),
//     groupedProducts: List<dynamic>.from(json["grouped_products"].map((x) => x)),
//     menuOrder: json["menu_order"],
//     priceHtml: json["price_html"],
//     relatedIds: List<int>.from(json["related_ids"].map((x) => x)),
//     metaData: List<MetaDatum>.from(
//       json["meta_data"].map((x) => MetaDatum.fromJson(x)),
//     ),
//     stockStatus: json["stock_status"],
//     hasOptions: json["has_options"],
//     postPassword: json["post_password"],
//     globalUniqueId: json["global_unique_id"],
//     amsDefaultVariationId: json["ams_default_variation_id"] ?? 0,
//     amsProductPointsReward: json["ams_product_points_reward"] == null
//         ? null
//         : List<dynamic>.from(json["ams_product_points_reward"].map((x) => x)),
//     // amsProductDiscountPercentage: json["ams_product_discount_percentage"],
//     amsProductDiscountPercentage:
//         (json["ams_product_discount_percentage"] is int)
//         ? (json["ams_product_discount_percentage"] as int).toDouble()
//         : (json["ams_product_discount_percentage"] ?? 0).toDouble(),
//     amsPriceToDisplay: json["ams_price_to_display"],
//     amsAcf: List<dynamic>.from(json["ams_acf"].map((x) => x)),
//     productUnits: ProductUnits.fromJson(json["product_units"]),
//     wcfmProductPolicyData: WcfmProductPolicyData.fromJson(
//       json["wcfm_product_policy_data"],
//     ),
//     showAdditionalInfoTab: json["showAdditionalInfoTab"],
//     store: Store.fromJson(json["store"]),
//     productRestirctionMessage: json["product_restirction_message"],
//     links: Links.fromJson(json["_links"]),
//   );

//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "slug": slug,
//     "permalink": permalink,
//     "date_created": dateCreated.toIso8601String(),
//     "date_created_gmt": dateCreatedGmt.toIso8601String(),
//     "date_modified": dateModified.toIso8601String(),
//     "date_modified_gmt": dateModifiedGmt.toIso8601String(),
//     "type": type,
//     "status": status,
//     "featured": featured,
//     "catalog_visibility": catalogVisibility,
//     "description": description,
//     "short_description": shortDescription,
//     "sku": sku,
//     "price": price,
//     "regular_price": regularPrice,
//     "sale_price": salePrice,
//     "date_on_sale_from": dateOnSaleFrom,
//     "date_on_sale_from_gmt": dateOnSaleFromGmt,
//     "date_on_sale_to": dateOnSaleTo,
//     "date_on_sale_to_gmt": dateOnSaleToGmt,
//     "on_sale": onSale,
//     "purchasable": purchasable,
//     "total_sales": totalSales,
//     "virtual": virtual,
//     "downloadable": downloadable,
//     "downloads": List<dynamic>.from(downloads.map((x) => x)),
//     "download_limit": downloadLimit,
//     "download_expiry": downloadExpiry,
//     "external_url": externalUrl,
//     "button_text": buttonText,
//     "tax_status": taxStatus,
//     "tax_class": taxClass,
//     "manage_stock": manageStock,
//     "stock_quantity": stockQuantity,
//     "backorders": backorders,
//     "backorders_allowed": backordersAllowed,
//     "backordered": backordered,
//     "low_stock_amount": lowStockAmount,
//     "sold_individually": soldIndividually,
//     "weight": weight,
//     "dimensions": dimensions.toJson(),
//     "shipping_required": shippingRequired,
//     "shipping_taxable": shippingTaxable,
//     "shipping_class": shippingClass,
//     "shipping_class_id": shippingClassId,
//     "reviews_allowed": reviewsAllowed,
//     "average_rating": averageRating,
//     "rating_count": ratingCount,
//     "upsell_ids": List<dynamic>.from(upsellIds.map((x) => x)),
//     "cross_sell_ids": List<dynamic>.from(crossSellIds.map((x) => x)),
//     "parent_id": parentId,
//     "purchase_note": purchaseNote,
//     "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
//     "brands": List<dynamic>.from(brands.map((x) => x)),
//     "tags": List<dynamic>.from(tags.map((x) => x)),
//     "images": List<dynamic>.from(images.map((x) => x.toJson())),
//     "attributes": List<dynamic>.from(attributes.map((x) => x)),
//     "default_attributes": List<dynamic>.from(defaultAttributes.map((x) => x)),
//     "variations": List<dynamic>.from(variations.map((x) => x)),
//     "grouped_products": List<dynamic>.from(groupedProducts.map((x) => x)),
//     "menu_order": menuOrder,
//     "price_html": priceHtml,
//     "related_ids": List<dynamic>.from(relatedIds.map((x) => x)),
//     "meta_data": List<dynamic>.from(metaData.map((x) => x.toJson())),
//     "stock_status": stockStatus,
//     "has_options": hasOptions,
//     "post_password": postPassword,
//     "global_unique_id": globalUniqueId,
//     "ams_default_variation_id": amsDefaultVariationId,
//     "ams_product_points_reward": List<dynamic>.from(
//       amsProductPointsReward!.map((x) => x),
//     ),
//     // "ams_product_discount_percentage": amsProductDiscountPercentage,
//     "ams_product_discount_percentage": amsProductDiscountPercentage,
//     "ams_price_to_display": amsPriceToDisplay,
//     "ams_acf": List<dynamic>.from(amsAcf.map((x) => x)),
//     "product_units": productUnits.toJson(),
//     "wcfm_product_policy_data": wcfmProductPolicyData.toJson(),
//     "showAdditionalInfoTab": showAdditionalInfoTab,
//     "store": store.toJson(),
//     "product_restirction_message": productRestirctionMessage,
//     "_links": links.toJson(),
//   };
// }

// class Category {
//   int id;
//   String name;
//   String slug;

//   Category({required this.id, required this.name, required this.slug});

//   factory Category.fromJson(Map<String, dynamic> json) =>
//       Category(id: json["id"], name: json["name"], slug: json["slug"]);

//   Map<String, dynamic> toJson() => {"id": id, "name": name, "slug": slug};
// }

// class Dimensions {
//   String length;
//   String width;
//   String height;

//   Dimensions({required this.length, required this.width, required this.height});

//   factory Dimensions.fromJson(Map<String, dynamic> json) => Dimensions(
//     length: json["length"],
//     width: json["width"],
//     height: json["height"],
//   );

//   Map<String, dynamic> toJson() => {
//     "length": length,
//     "width": width,
//     "height": height,
//   };
// }

// class Image {
//   int id;
//   DateTime dateCreated;
//   DateTime dateCreatedGmt;
//   DateTime dateModified;
//   DateTime dateModifiedGmt;
//   String src;
//   String name;
//   String alt;
//   String thumbnail;
//   String? medium;
//   String the1536X1536;
//   String the2048X2048;
//   String ecademyDefaultThumb;
//   String ecademyAdvisorThumbOne;
//   String ecademyAdvisorThumbTwo;
//   String ecademyBlogThumb;
//   String ecademy400X400;
//   String ecademy810X545;
//   String ecademy850X900Thumb;
//   String ecademy100X110Thumb;
//   String ecademy620X455Thumb;
//   String woocommerceThumbnail;
//   String woocommerceSingle;
//   String woocommerceGalleryThumbnail;

//   Image({
//     required this.id,
//     required this.dateCreated,
//     required this.dateCreatedGmt,
//     required this.dateModified,
//     required this.dateModifiedGmt,
//     required this.src,
//     required this.name,
//     required this.alt,
//     required this.thumbnail,
//     this.medium,
//     required this.the1536X1536,
//     required this.the2048X2048,
//     required this.ecademyDefaultThumb,
//     required this.ecademyAdvisorThumbOne,
//     required this.ecademyAdvisorThumbTwo,
//     required this.ecademyBlogThumb,
//     required this.ecademy400X400,
//     required this.ecademy810X545,
//     required this.ecademy850X900Thumb,
//     required this.ecademy100X110Thumb,
//     required this.ecademy620X455Thumb,
//     required this.woocommerceThumbnail,
//     required this.woocommerceSingle,
//     required this.woocommerceGalleryThumbnail,
//   });

//   factory Image.fromJson(Map<String, dynamic> json) => Image(
//     id: json["id"],
//     dateCreated: DateTime.parse(json["date_created"]),
//     dateCreatedGmt: DateTime.parse(json["date_created_gmt"]),
//     dateModified: DateTime.parse(json["date_modified"]),
//     dateModifiedGmt: DateTime.parse(json["date_modified_gmt"]),
//     src: json["src"],
//     name: json["name"],
//     alt: json["alt"],
//     thumbnail: json["thumbnail"],
//     medium: json["medium"],
//     the1536X1536: json["1536x1536"],
//     the2048X2048: json["2048x2048"],
//     ecademyDefaultThumb: json["ecademy_default_thumb"],
//     ecademyAdvisorThumbOne: json["ecademy_advisor_thumb_one"],
//     ecademyAdvisorThumbTwo: json["ecademy_advisor_thumb_two"],
//     ecademyBlogThumb: json["ecademy_blog_thumb"],
//     ecademy400X400: json["ecademy_400x400"],
//     ecademy810X545: json["ecademy_810x545"],
//     ecademy850X900Thumb: json["ecademy_850x900_thumb"],
//     ecademy100X110Thumb: json["ecademy_100x110_thumb"],
//     ecademy620X455Thumb: json["ecademy_620x455_thumb"],
//     woocommerceThumbnail: json["woocommerce_thumbnail"],
//     woocommerceSingle: json["woocommerce_single"],
//     woocommerceGalleryThumbnail: json["woocommerce_gallery_thumbnail"],
//   );

//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "date_created": dateCreated.toIso8601String(),
//     "date_created_gmt": dateCreatedGmt.toIso8601String(),
//     "date_modified": dateModified.toIso8601String(),
//     "date_modified_gmt": dateModifiedGmt.toIso8601String(),
//     "src": src,
//     "name": name,
//     "alt": alt,
//     "thumbnail": thumbnail,
//     "medium": medium,
//     "1536x1536": the1536X1536,
//     "2048x2048": the2048X2048,
//     "ecademy_default_thumb": ecademyDefaultThumb,
//     "ecademy_advisor_thumb_one": ecademyAdvisorThumbOne,
//     "ecademy_advisor_thumb_two": ecademyAdvisorThumbTwo,
//     "ecademy_blog_thumb": ecademyBlogThumb,
//     "ecademy_400x400": ecademy400X400,
//     "ecademy_810x545": ecademy810X545,
//     "ecademy_850x900_thumb": ecademy850X900Thumb,
//     "ecademy_100x110_thumb": ecademy100X110Thumb,
//     "ecademy_620x455_thumb": ecademy620X455Thumb,
//     "woocommerce_thumbnail": woocommerceThumbnail,
//     "woocommerce_single": woocommerceSingle,
//     "woocommerce_gallery_thumbnail": woocommerceGalleryThumbnail,
//   };
// }

// class Links {
//   List<Self> self;
//   List<Collection> collection;

//   Links({required this.self, required this.collection});

//   factory Links.fromJson(Map<String, dynamic> json) => Links(
//     self: List<Self>.from(json["self"].map((x) => Self.fromJson(x))),
//     collection: List<Collection>.from(
//       json["collection"].map((x) => Collection.fromJson(x)),
//     ),
//   );

//   Map<String, dynamic> toJson() => {
//     "self": List<dynamic>.from(self.map((x) => x.toJson())),
//     "collection": List<dynamic>.from(collection.map((x) => x.toJson())),
//   };
// }

// class Collection {
//   String href;

//   Collection({required this.href});

//   factory Collection.fromJson(Map<String, dynamic> json) =>
//       Collection(href: json["href"]);

//   Map<String, dynamic> toJson() => {"href": href};
// }

// class Self {
//   String href;
//   TargetHints targetHints;

//   Self({required this.href, required this.targetHints});

//   factory Self.fromJson(Map<String, dynamic> json) => Self(
//     href: json["href"],
//     targetHints: TargetHints.fromJson(json["targetHints"]),
//   );

//   Map<String, dynamic> toJson() => {
//     "href": href,
//     "targetHints": targetHints.toJson(),
//   };
// }

// class TargetHints {
//   List<String> allow;

//   TargetHints({required this.allow});

//   factory TargetHints.fromJson(Map<String, dynamic> json) =>
//       TargetHints(allow: List<String>.from(json["allow"].map((x) => x)));

//   Map<String, dynamic> toJson() => {
//     "allow": List<dynamic>.from(allow.map((x) => x)),
//   };
// }

// class MetaDatum {
//   int id;
//   String key;
//   dynamic value;

//   MetaDatum({required this.id, required this.key, required this.value});

//   factory MetaDatum.fromJson(Map<String, dynamic> json) =>
//       MetaDatum(id: json["id"], key: json["key"], value: json["value"]);

//   Map<String, dynamic> toJson() => {"id": id, "key": key, "value": value};
// }

// class ProductUnits {
//   String weightUnit;
//   String dimensionUnit;

//   ProductUnits({required this.weightUnit, required this.dimensionUnit});

//   factory ProductUnits.fromJson(Map<String, dynamic> json) => ProductUnits(
//     weightUnit: json["weight_unit"],
//     dimensionUnit: json["dimension_unit"],
//   );

//   Map<String, dynamic> toJson() => {
//     "weight_unit": weightUnit,
//     "dimension_unit": dimensionUnit,
//   };
// }

// class Store {
//   int vendorId;
//   String vendorDisplayName;
//   String vendorShopName;
//   String formattedDisplayName;
//   String storeHideEmail;
//   String storeHidePhone;
//   String storeHideAddress;
//   String storeHideDescription;
//   String storeHidePolicy;
//   int storeProductsPerPage;
//   String vendorEmail;
//   String vendorPhone;
//   String vendorAddress;
//   String disableVendor;
//   String isStoreOffline;
//   String vendorShopLogo;
//   String vendorBannerType;
//   String vendorBanner;
//   String mobileBanner;
//   String vendorListBannerType;
//   String vendorListBanner;
//   String storeRating;
//   String emailVerified;
//   List<VendorAdditionalInfo> vendorAdditionalInfo;
//   String vendorDescription;
//   WcfmProductPolicyData vendorPolicies;
//   StoreTabHeadings storeTabHeadings;

//   Store({
//     required this.vendorId,
//     required this.vendorDisplayName,
//     required this.vendorShopName,
//     required this.formattedDisplayName,
//     required this.storeHideEmail,
//     required this.storeHidePhone,
//     required this.storeHideAddress,
//     required this.storeHideDescription,
//     required this.storeHidePolicy,
//     required this.storeProductsPerPage,
//     required this.vendorEmail,
//     required this.vendorPhone,
//     required this.vendorAddress,
//     required this.disableVendor,
//     required this.isStoreOffline,
//     required this.vendorShopLogo,
//     required this.vendorBannerType,
//     required this.vendorBanner,
//     required this.mobileBanner,
//     required this.vendorListBannerType,
//     required this.vendorListBanner,
//     required this.storeRating,
//     required this.emailVerified,
//     required this.vendorAdditionalInfo,
//     required this.vendorDescription,
//     required this.vendorPolicies,
//     required this.storeTabHeadings,
//   });

//   factory Store.fromJson(Map<String, dynamic> json) => Store(
//     vendorId: json["vendor_id"],
//     vendorDisplayName: json["vendor_display_name"],
//     vendorShopName: json["vendor_shop_name"],
//     formattedDisplayName: json["formatted_display_name"],
//     storeHideEmail: json["store_hide_email"],
//     storeHidePhone: json["store_hide_phone"],
//     storeHideAddress: json["store_hide_address"],
//     storeHideDescription: json["store_hide_description"],
//     storeHidePolicy: json["store_hide_policy"],
//     storeProductsPerPage: json["store_products_per_page"],
//     vendorEmail: json["vendor_email"],
//     vendorPhone: json["vendor_phone"],
//     vendorAddress: json["vendor_address"],
//     disableVendor: json["disable_vendor"],
//     isStoreOffline: json["is_store_offline"],
//     vendorShopLogo: json["vendor_shop_logo"],
//     vendorBannerType: json["vendor_banner_type"],
//     vendorBanner: json["vendor_banner"],
//     mobileBanner: json["mobile_banner"],
//     vendorListBannerType: json["vendor_list_banner_type"],
//     vendorListBanner: json["vendor_list_banner"],
//     storeRating: json["store_rating"],
//     emailVerified: json["email_verified"],
//     vendorAdditionalInfo: List<VendorAdditionalInfo>.from(
//       json["vendor_additional_info"].map(
//         (x) => VendorAdditionalInfo.fromJson(x),
//       ),
//     ),
//     vendorDescription: json["vendor_description"],
//     vendorPolicies: WcfmProductPolicyData.fromJson(json["vendor_policies"]),
//     storeTabHeadings: StoreTabHeadings.fromJson(json["store_tab_headings"]),
//   );

//   Map<String, dynamic> toJson() => {
//     "vendor_id": vendorId,
//     "vendor_display_name": vendorDisplayName,
//     "vendor_shop_name": vendorShopName,
//     "formatted_display_name": formattedDisplayName,
//     "store_hide_email": storeHideEmail,
//     "store_hide_phone": storeHidePhone,
//     "store_hide_address": storeHideAddress,
//     "store_hide_description": storeHideDescription,
//     "store_hide_policy": storeHidePolicy,
//     "store_products_per_page": storeProductsPerPage,
//     "vendor_email": vendorEmail,
//     "vendor_phone": vendorPhone,
//     "vendor_address": vendorAddress,
//     "disable_vendor": disableVendor,
//     "is_store_offline": isStoreOffline,
//     "vendor_shop_logo": vendorShopLogo,
//     "vendor_banner_type": vendorBannerType,
//     "vendor_banner": vendorBanner,
//     "mobile_banner": mobileBanner,
//     "vendor_list_banner_type": vendorListBannerType,
//     "vendor_list_banner": vendorListBanner,
//     "store_rating": storeRating,
//     "email_verified": emailVerified,
//     "vendor_additional_info": List<dynamic>.from(
//       vendorAdditionalInfo.map((x) => x.toJson()),
//     ),
//     "vendor_description": vendorDescription,
//     "vendor_policies": vendorPolicies.toJson(),
//     "store_tab_headings": storeTabHeadings.toJson(),
//   };
// }

// class StoreTabHeadings {
//   String products;
//   String about;
//   String policies;
//   String reviews;

//   StoreTabHeadings({
//     required this.products,
//     required this.about,
//     required this.policies,
//     required this.reviews,
//   });

//   factory StoreTabHeadings.fromJson(Map<String, dynamic> json) =>
//       StoreTabHeadings(
//         products: json["products"],
//         about: json["about"],
//         policies: json["policies"],
//         reviews: json["reviews"],
//       );

//   Map<String, dynamic> toJson() => {
//     "products": products,
//     "about": about,
//     "policies": policies,
//     "reviews": reviews,
//   };
// }

// class VendorAdditionalInfo {
//   String type;
//   String label;
//   String options;
//   String content;
//   String helpText;
//   String name;
//   String value;

//   VendorAdditionalInfo({
//     required this.type,
//     required this.label,
//     required this.options,
//     required this.content,
//     required this.helpText,
//     required this.name,
//     required this.value,
//   });

//   factory VendorAdditionalInfo.fromJson(Map<String, dynamic> json) =>
//       VendorAdditionalInfo(
//         type: json["type"],
//         label: json["label"],
//         options: json["options"],
//         content: json["content"],
//         helpText: json["help_text"],
//         name: json["name"],
//         value: json["value"],
//       );

//   Map<String, dynamic> toJson() => {
//     "type": type,
//     "label": label,
//     "options": options,
//     "content": content,
//     "help_text": helpText,
//     "name": name,
//     "value": value,
//   };
// }

// class WcfmProductPolicyData {
//   String shippingPolicyHeading;
//   String shippingPolicy;
//   String refundPolicyHeading;
//   String refundPolicy;
//   String cancellationPolicyHeading;
//   String cancellationPolicy;
//   bool? visible;
//   String? tabTitle;

//   WcfmProductPolicyData({
//     required this.shippingPolicyHeading,
//     required this.shippingPolicy,
//     required this.refundPolicyHeading,
//     required this.refundPolicy,
//     required this.cancellationPolicyHeading,
//     required this.cancellationPolicy,
//     this.visible,
//     this.tabTitle,
//   });

//   factory WcfmProductPolicyData.fromJson(Map<String, dynamic> json) =>
//       WcfmProductPolicyData(
//         shippingPolicyHeading: json["shipping_policy_heading"],
//         shippingPolicy: json["shipping_policy"],
//         refundPolicyHeading: json["refund_policy_heading"],
//         refundPolicy: json["refund_policy"],
//         cancellationPolicyHeading: json["cancellation_policy_heading"],
//         cancellationPolicy: json["cancellation_policy"],
//         visible: json["visible"],
//         tabTitle: json["tab_title"],
//       );

//   Map<String, dynamic> toJson() => {
//     "shipping_policy_heading": shippingPolicyHeading,
//     "shipping_policy": shippingPolicy,
//     "refund_policy_heading": refundPolicyHeading,
//     "refund_policy": refundPolicy,
//     "cancellation_policy_heading": cancellationPolicyHeading,
//     "cancellation_policy": cancellationPolicy,
//     "visible": visible,
//     "tab_title": tabTitle,
//   };
// }

// To parse this JSON data, do
//
//     final productDetailsModel = productDetailsModelFromJson(jsonString);

import 'dart:convert';

ProductDetailsModel productDetailsModelFromJson(String str) =>
    ProductDetailsModel.fromJson(json.decode(str));

String productDetailsModelToJson(ProductDetailsModel data) =>
    json.encode(data.toJson());

class ProductDetailsModel {
  int? id;
  String? name;
  String? slug;
  String? permalink;
  DateTime? dateCreated;
  DateTime? dateCreatedGmt;
  DateTime? dateModified;
  DateTime? dateModifiedGmt;
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
  dynamic? dateOnSaleFrom;
  dynamic? dateOnSaleFromGmt;
  dynamic? dateOnSaleTo;
  dynamic? dateOnSaleToGmt;
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
  dynamic? stockQuantity;
  String? backorders;
  bool? backordersAllowed;
  bool? backordered;
  dynamic? lowStockAmount;
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
  List<dynamic>? upsellIds;
  List<dynamic>? crossSellIds;
  int? parentId;
  String? purchaseNote;
  List<Category>? categories;
  List<dynamic>? brands;
  List<dynamic>? tags;
  List<Image>? images;
  List<dynamic>? attributes;
  List<dynamic>? defaultAttributes;
  List<dynamic>? variations;
  List<dynamic>? groupedProducts;
  int? menuOrder;
  String? priceHtml;
  List<int>? relatedIds;
  List<MetaDatum>? metaData;
  String? stockStatus;
  bool? hasOptions;
  String? postPassword;
  String? globalUniqueId;
  int? amsDefaultVariationId;
  List<dynamic>? amsProductPointsReward;
  double? amsProductDiscountPercentage;
  int? amsPriceToDisplay;
  List<dynamic>? amsAcf;
  ProductUnits? productUnits;
  WcfmProductPolicyData? wcfmProductPolicyData;
  bool? showAdditionalInfoTab;
  Store? store;
  String? productRestirctionMessage;
  Links? links;

  ProductDetailsModel({
    this.id,
    this.name,
    this.slug,
    this.permalink,
    this.dateCreated,
    this.dateCreatedGmt,
    this.dateModified,
    this.dateModifiedGmt,
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
    this.dateOnSaleFromGmt,
    this.dateOnSaleTo,
    this.dateOnSaleToGmt,
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
    this.lowStockAmount,
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
    this.upsellIds,
    this.crossSellIds,
    this.parentId,
    this.purchaseNote,
    this.categories,
    this.brands,
    this.tags,
    this.images,
    this.attributes,
    this.defaultAttributes,
    this.variations,
    this.groupedProducts,
    this.menuOrder,
    this.priceHtml,
    this.relatedIds,
    this.metaData,
    this.stockStatus,
    this.hasOptions,
    this.postPassword,
    this.globalUniqueId,
    this.amsDefaultVariationId,
    this.amsProductPointsReward,
    this.amsProductDiscountPercentage,
    this.amsPriceToDisplay,
    this.amsAcf,
    this.productUnits,
    this.wcfmProductPolicyData,
    this.showAdditionalInfoTab,
    this.store,
    this.productRestirctionMessage,
    this.links,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) =>
      ProductDetailsModel(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        permalink: json["permalink"],
        dateCreated: json["date_created"] != null
            ? DateTime.parse(json["date_created"])
            : null,
        dateCreatedGmt: json["date_created_gmt"] != null
            ? DateTime.parse(json["date_created_gmt"])
            : null,
        dateModified: json["date_modified"] != null
            ? DateTime.parse(json["date_modified"])
            : null,
        dateModifiedGmt: json["date_modified_gmt"] != null
            ? DateTime.parse(json["date_modified_gmt"])
            : null,
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
        dateOnSaleFromGmt: json["date_on_sale_from_gmt"],
        dateOnSaleTo: json["date_on_sale_to"],
        dateOnSaleToGmt: json["date_on_sale_to_gmt"],
        onSale: json["on_sale"],
        purchasable: json["purchasable"],
        totalSales: json["total_sales"],
        virtual: json["virtual"],
        downloadable: json["downloadable"],
        downloads: json["downloads"] != null
            ? List<dynamic>.from(json["downloads"].map((x) => x))
            : null,
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
        lowStockAmount: json["low_stock_amount"],
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
        upsellIds: json["upsell_ids"] != null
            ? List<dynamic>.from(json["upsell_ids"].map((x) => x))
            : null,
        crossSellIds: json["cross_sell_ids"] != null
            ? List<dynamic>.from(json["cross_sell_ids"].map((x) => x))
            : null,
        parentId: json["parent_id"],
        purchaseNote: json["purchase_note"],
        categories: json["categories"] != null
            ? List<Category>.from(
                json["categories"].map((x) => Category.fromJson(x)),
              )
            : null,
        brands: json["brands"] != null
            ? List<dynamic>.from(json["brands"].map((x) => x))
            : null,
        tags: json["tags"] != null
            ? List<dynamic>.from(json["tags"].map((x) => x))
            : null,
        images: json["images"] != null
            ? List<Image>.from(json["images"].map((x) => Image.fromJson(x)))
            : null,
        attributes: json["attributes"] != null
            ? List<dynamic>.from(json["attributes"].map((x) => x))
            : null,
        defaultAttributes: json["default_attributes"] != null
            ? List<dynamic>.from(json["default_attributes"].map((x) => x))
            : null,
        variations: json["variations"] != null
            ? List<dynamic>.from(json["variations"].map((x) => x))
            : null,
        groupedProducts: json["grouped_products"] != null
            ? List<dynamic>.from(json["grouped_products"].map((x) => x))
            : null,
        menuOrder: json["menu_order"],
        priceHtml: json["price_html"],
        relatedIds: json["related_ids"] != null
            ? List<int>.from(json["related_ids"].map((x) => x))
            : null,
        metaData: json["meta_data"] != null
            ? List<MetaDatum>.from(
                json["meta_data"].map((x) => MetaDatum.fromJson(x)),
              )
            : null,
        stockStatus: json["stock_status"],
        hasOptions: json["has_options"],
        postPassword: json["post_password"],
        globalUniqueId: json["global_unique_id"],
        amsDefaultVariationId: json["ams_default_variation_id"] ?? 0,
        amsProductPointsReward: json["ams_product_points_reward"] == null
            ? null
            : List<dynamic>.from(
                json["ams_product_points_reward"].map((x) => x),
              ),
        amsProductDiscountPercentage:
            (json["ams_product_discount_percentage"] is int)
            ? (json["ams_product_discount_percentage"] as int).toDouble()
            : (json["ams_product_discount_percentage"] ?? 0).toDouble(),
        amsPriceToDisplay: json["ams_price_to_display"],
        amsAcf: json["ams_acf"] != null
            ? List<dynamic>.from(json["ams_acf"].map((x) => x))
            : null,
        productUnits: json["product_units"] != null
            ? ProductUnits.fromJson(json["product_units"])
            : null,
        wcfmProductPolicyData: json["wcfm_product_policy_data"] != null
            ? WcfmProductPolicyData.fromJson(json["wcfm_product_policy_data"])
            : null,
        showAdditionalInfoTab: json["showAdditionalInfoTab"],
        store: json["store"] != null ? Store.fromJson(json["store"]) : null,
        productRestirctionMessage: json["product_restirction_message"],
        links: json["_links"] != null ? Links.fromJson(json["_links"]) : null,
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "permalink": permalink,
    "date_created": dateCreated?.toIso8601String(),
    "date_created_gmt": dateCreatedGmt?.toIso8601String(),
    "date_modified": dateModified?.toIso8601String(),
    "date_modified_gmt": dateModifiedGmt?.toIso8601String(),
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
    "date_on_sale_from_gmt": dateOnSaleFromGmt,
    "date_on_sale_to": dateOnSaleTo,
    "date_on_sale_to_gmt": dateOnSaleToGmt,
    "on_sale": onSale,
    "purchasable": purchasable,
    "total_sales": totalSales,
    "virtual": virtual,
    "downloadable": downloadable,
    "downloads": downloads?.map((x) => x).toList(),
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
    "low_stock_amount": lowStockAmount,
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
    "upsell_ids": upsellIds?.map((x) => x).toList(),
    "cross_sell_ids": crossSellIds?.map((x) => x).toList(),
    "parent_id": parentId,
    "purchase_note": purchaseNote,
    "categories": categories?.map((x) => x.toJson()).toList(),
    "brands": brands?.map((x) => x).toList(),
    "tags": tags?.map((x) => x).toList(),
    "images": images?.map((x) => x.toJson()).toList(),
    "attributes": attributes?.map((x) => x).toList(),
    "default_attributes": defaultAttributes?.map((x) => x).toList(),
    "variations": variations?.map((x) => x).toList(),
    "grouped_products": groupedProducts?.map((x) => x).toList(),
    "menu_order": menuOrder,
    "price_html": priceHtml,
    "related_ids": relatedIds?.map((x) => x).toList(),
    "meta_data": metaData?.map((x) => x.toJson()).toList(),
    "stock_status": stockStatus,
    "has_options": hasOptions,
    "post_password": postPassword,
    "global_unique_id": globalUniqueId,
    "ams_default_variation_id": amsDefaultVariationId,
    "ams_product_points_reward": amsProductPointsReward?.map((x) => x).toList(),
    "ams_product_discount_percentage": amsProductDiscountPercentage,
    "ams_price_to_display": amsPriceToDisplay,
    "ams_acf": amsAcf?.map((x) => x).toList(),
    "product_units": productUnits?.toJson(),
    "wcfm_product_policy_data": wcfmProductPolicyData?.toJson(),
    "showAdditionalInfoTab": showAdditionalInfoTab,
    "store": store?.toJson(),
    "product_restirction_message": productRestirctionMessage,
    "_links": links?.toJson(),
  };
}

class Category {
  int? id;
  String? name;
  String? slug;

  Category({this.id, this.name, this.slug});

  factory Category.fromJson(Map<String, dynamic> json) =>
      Category(id: json["id"], name: json["name"], slug: json["slug"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name, "slug": slug};
}

class Dimensions {
  String? length;
  String? width;
  String? height;

  Dimensions({this.length, this.width, this.height});

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

class Image {
  int? id;
  DateTime? dateCreated;
  DateTime? dateCreatedGmt;
  DateTime? dateModified;
  DateTime? dateModifiedGmt;
  String? src;
  String? name;
  String? alt;
  String? thumbnail;
  String? medium;
  String? the1536X1536;
  String? the2048X2048;
  String? ecademyDefaultThumb;
  String? ecademyAdvisorThumbOne;
  String? ecademyAdvisorThumbTwo;
  String? ecademyBlogThumb;
  String? ecademy400X400;
  String? ecademy810X545;
  String? ecademy850X900Thumb;
  String? ecademy100X110Thumb;
  String? ecademy620X455Thumb;
  String? woocommerceThumbnail;
  String? woocommerceSingle;
  String? woocommerceGalleryThumbnail;

  Image({
    this.id,
    this.dateCreated,
    this.dateCreatedGmt,
    this.dateModified,
    this.dateModifiedGmt,
    this.src,
    this.name,
    this.alt,
    this.thumbnail,
    this.medium,
    this.the1536X1536,
    this.the2048X2048,
    this.ecademyDefaultThumb,
    this.ecademyAdvisorThumbOne,
    this.ecademyAdvisorThumbTwo,
    this.ecademyBlogThumb,
    this.ecademy400X400,
    this.ecademy810X545,
    this.ecademy850X900Thumb,
    this.ecademy100X110Thumb,
    this.ecademy620X455Thumb,
    this.woocommerceThumbnail,
    this.woocommerceSingle,
    this.woocommerceGalleryThumbnail,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    id: json["id"],
    dateCreated: json["date_created"] != null
        ? DateTime.parse(json["date_created"])
        : null,
    dateCreatedGmt: json["date_created_gmt"] != null
        ? DateTime.parse(json["date_created_gmt"])
        : null,
    dateModified: json["date_modified"] != null
        ? DateTime.parse(json["date_modified"])
        : null,
    dateModifiedGmt: json["date_modified_gmt"] != null
        ? DateTime.parse(json["date_modified_gmt"])
        : null,
    src: json["src"],
    name: json["name"],
    alt: json["alt"],
    thumbnail: json["thumbnail"],
    medium: json["medium"],
    the1536X1536: json["1536x1536"],
    the2048X2048: json["2048x2048"],
    ecademyDefaultThumb: json["ecademy_default_thumb"],
    ecademyAdvisorThumbOne: json["ecademy_advisor_thumb_one"],
    ecademyAdvisorThumbTwo: json["ecademy_advisor_thumb_two"],
    ecademyBlogThumb: json["ecademy_blog_thumb"],
    ecademy400X400: json["ecademy_400x400"],
    ecademy810X545: json["ecademy_810x545"],
    ecademy850X900Thumb: json["ecademy_850x900_thumb"],
    ecademy100X110Thumb: json["ecademy_100x110_thumb"],
    ecademy620X455Thumb: json["ecademy_620x455_thumb"],
    woocommerceThumbnail: json["woocommerce_thumbnail"],
    woocommerceSingle: json["woocommerce_single"],
    woocommerceGalleryThumbnail: json["woocommerce_gallery_thumbnail"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date_created": dateCreated?.toIso8601String(),
    "date_created_gmt": dateCreatedGmt?.toIso8601String(),
    "date_modified": dateModified?.toIso8601String(),
    "date_modified_gmt": dateModifiedGmt?.toIso8601String(),
    "src": src,
    "name": name,
    "alt": alt,
    "thumbnail": thumbnail,
    "medium": medium,
    "1536x1536": the1536X1536,
    "2048x2048": the2048X2048,
    "ecademy_default_thumb": ecademyDefaultThumb,
    "ecademy_advisor_thumb_one": ecademyAdvisorThumbOne,
    "ecademy_advisor_thumb_two": ecademyAdvisorThumbTwo,
    "ecademy_blog_thumb": ecademyBlogThumb,
    "ecademy_400x400": ecademy400X400,
    "ecademy_810x545": ecademy810X545,
    "ecademy_850x900_thumb": ecademy850X900Thumb,
    "ecademy_100x110_thumb": ecademy100X110Thumb,
    "ecademy_620x455_thumb": ecademy620X455Thumb,
    "woocommerce_thumbnail": woocommerceThumbnail,
    "woocommerce_single": woocommerceSingle,
    "woocommerce_gallery_thumbnail": woocommerceGalleryThumbnail,
  };
}

class Links {
  List<Self>? self;
  List<Collection>? collection;

  Links({this.self, this.collection});

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    self: json["self"] != null
        ? List<Self>.from(json["self"].map((x) => Self.fromJson(x)))
        : null,
    collection: json["collection"] != null
        ? List<Collection>.from(
            json["collection"].map((x) => Collection.fromJson(x)),
          )
        : null,
  );

  Map<String, dynamic> toJson() => {
    "self": self?.map((x) => x.toJson()).toList(),
    "collection": collection?.map((x) => x.toJson()).toList(),
  };
}

class Collection {
  String? href;

  Collection({this.href});

  factory Collection.fromJson(Map<String, dynamic> json) =>
      Collection(href: json["href"]);

  Map<String, dynamic> toJson() => {"href": href};
}

class Self {
  String? href;
  TargetHints? targetHints;

  Self({this.href, this.targetHints});

  factory Self.fromJson(Map<String, dynamic> json) => Self(
    href: json["href"],
    targetHints: json["targetHints"] != null
        ? TargetHints.fromJson(json["targetHints"])
        : null,
  );

  Map<String, dynamic> toJson() => {
    "href": href,
    "targetHints": targetHints?.toJson(),
  };
}

class TargetHints {
  List<String>? allow;

  TargetHints({this.allow});

  factory TargetHints.fromJson(Map<String, dynamic> json) => TargetHints(
    allow: json["allow"] != null
        ? List<String>.from(json["allow"].map((x) => x))
        : null,
  );

  Map<String, dynamic> toJson() => {"allow": allow?.map((x) => x).toList()};
}

class MetaDatum {
  int? id;
  String? key;
  dynamic? value;

  MetaDatum({this.id, this.key, this.value});

  factory MetaDatum.fromJson(Map<String, dynamic> json) =>
      MetaDatum(id: json["id"], key: json["key"], value: json["value"]);

  Map<String, dynamic> toJson() => {"id": id, "key": key, "value": value};
}

class ProductUnits {
  String? weightUnit;
  String? dimensionUnit;

  ProductUnits({this.weightUnit, this.dimensionUnit});

  factory ProductUnits.fromJson(Map<String, dynamic> json) => ProductUnits(
    weightUnit: json["weight_unit"],
    dimensionUnit: json["dimension_unit"],
  );

  Map<String, dynamic> toJson() => {
    "weight_unit": weightUnit,
    "dimension_unit": dimensionUnit,
  };
}

class Store {
  int? vendorId;
  String? vendorDisplayName;
  String? vendorShopName;
  String? formattedDisplayName;
  String? storeHideEmail;
  String? storeHidePhone;
  String? storeHideAddress;
  String? storeHideDescription;
  String? storeHidePolicy;
  int? storeProductsPerPage;
  String? vendorEmail;
  String? vendorPhone;
  String? vendorAddress;
  String? disableVendor;
  String? isStoreOffline;
  String? vendorShopLogo;
  String? vendorBannerType;
  String? vendorBanner;
  String? mobileBanner;
  String? vendorListBannerType;
  String? vendorListBanner;
  String? storeRating;
  String? emailVerified;
  List<VendorAdditionalInfo>? vendorAdditionalInfo;
  String? vendorDescription;
  WcfmProductPolicyData? vendorPolicies;
  StoreTabHeadings? storeTabHeadings;

  Store({
    this.vendorId,
    this.vendorDisplayName,
    this.vendorShopName,
    this.formattedDisplayName,
    this.storeHideEmail,
    this.storeHidePhone,
    this.storeHideAddress,
    this.storeHideDescription,
    this.storeHidePolicy,
    this.storeProductsPerPage,
    this.vendorEmail,
    this.vendorPhone,
    this.vendorAddress,
    this.disableVendor,
    this.isStoreOffline,
    this.vendorShopLogo,
    this.vendorBannerType,
    this.vendorBanner,
    this.mobileBanner,
    this.vendorListBannerType,
    this.vendorListBanner,
    this.storeRating,
    this.emailVerified,
    this.vendorAdditionalInfo,
    this.vendorDescription,
    this.vendorPolicies,
    this.storeTabHeadings,
  });

  factory Store.fromJson(Map<String, dynamic> json) => Store(
    vendorId: json["vendor_id"],
    vendorDisplayName: json["vendor_display_name"],
    vendorShopName: json["vendor_shop_name"],
    formattedDisplayName: json["formatted_display_name"],
    storeHideEmail: json["store_hide_email"],
    storeHidePhone: json["store_hide_phone"],
    storeHideAddress: json["store_hide_address"],
    storeHideDescription: json["store_hide_description"],
    storeHidePolicy: json["store_hide_policy"],
    storeProductsPerPage: json["store_products_per_page"],
    vendorEmail: json["vendor_email"],
    vendorPhone: json["vendor_phone"],
    vendorAddress: json["vendor_address"],
    disableVendor: json["disable_vendor"],
    isStoreOffline: json["is_store_offline"],
    vendorShopLogo: json["vendor_shop_logo"],
    vendorBannerType: json["vendor_banner_type"],
    vendorBanner: json["vendor_banner"],
    mobileBanner: json["mobile_banner"],
    vendorListBannerType: json["vendor_list_banner_type"],
    vendorListBanner: json["vendor_list_banner"],
    storeRating: json["store_rating"],
    emailVerified: json["email_verified"],
    vendorAdditionalInfo: json["vendor_additional_info"] != null
        ? List<VendorAdditionalInfo>.from(
            json["vendor_additional_info"].map(
              (x) => VendorAdditionalInfo.fromJson(x),
            ),
          )
        : null,
    vendorDescription: json["vendor_description"],
    vendorPolicies: json["vendor_policies"] != null
        ? WcfmProductPolicyData.fromJson(json["vendor_policies"])
        : null,
    storeTabHeadings: json["store_tab_headings"] != null
        ? StoreTabHeadings.fromJson(json["store_tab_headings"])
        : null,
  );

  Map<String, dynamic> toJson() => {
    "vendor_id": vendorId,
    "vendor_display_name": vendorDisplayName,
    "vendor_shop_name": vendorShopName,
    "formatted_display_name": formattedDisplayName,
    "store_hide_email": storeHideEmail,
    "store_hide_phone": storeHidePhone,
    "store_hide_address": storeHideAddress,
    "store_hide_description": storeHideDescription,
    "store_hide_policy": storeHidePolicy,
    "store_products_per_page": storeProductsPerPage,
    "vendor_email": vendorEmail,
    "vendor_phone": vendorPhone,
    "vendor_address": vendorAddress,
    "disable_vendor": disableVendor,
    "is_store_offline": isStoreOffline,
    "vendor_shop_logo": vendorShopLogo,
    "vendor_banner_type": vendorBannerType,
    "vendor_banner": vendorBanner,
    "mobile_banner": mobileBanner,
    "vendor_list_banner_type": vendorListBannerType,
    "vendor_list_banner": vendorListBanner,
    "store_rating": storeRating,
    "email_verified": emailVerified,
    "vendor_additional_info": vendorAdditionalInfo
        ?.map((x) => x.toJson())
        .toList(),
    "vendor_description": vendorDescription,
    "vendor_policies": vendorPolicies?.toJson(),
    "store_tab_headings": storeTabHeadings?.toJson(),
  };
}

class StoreTabHeadings {
  String? products;
  String? about;
  String? policies;
  String? reviews;

  StoreTabHeadings({this.products, this.about, this.policies, this.reviews});

  factory StoreTabHeadings.fromJson(Map<String, dynamic> json) =>
      StoreTabHeadings(
        products: json["products"],
        about: json["about"],
        policies: json["policies"],
        reviews: json["reviews"],
      );

  Map<String, dynamic> toJson() => {
    "products": products,
    "about": about,
    "policies": policies,
    "reviews": reviews,
  };
}

class VendorAdditionalInfo {
  String? type;
  String? label;
  String? options;
  String? content;
  String? helpText;
  String? name;
  String? value;

  VendorAdditionalInfo({
    this.type,
    this.label,
    this.options,
    this.content,
    this.helpText,
    this.name,
    this.value,
  });

  factory VendorAdditionalInfo.fromJson(Map<String, dynamic> json) =>
      VendorAdditionalInfo(
        type: json["type"],
        label: json["label"],
        options: json["options"],
        content: json["content"],
        helpText: json["help_text"],
        name: json["name"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
    "type": type,
    "label": label,
    "options": options,
    "content": content,
    "help_text": helpText,
    "name": name,
    "value": value,
  };
}

class WcfmProductPolicyData {
  String? shippingPolicyHeading;
  String? shippingPolicy;
  String? refundPolicyHeading;
  String? refundPolicy;
  String? cancellationPolicyHeading;
  String? cancellationPolicy;
  bool? visible;
  String? tabTitle;

  WcfmProductPolicyData({
    this.shippingPolicyHeading,
    this.shippingPolicy,
    this.refundPolicyHeading,
    this.refundPolicy,
    this.cancellationPolicyHeading,
    this.cancellationPolicy,
    this.visible,
    this.tabTitle,
  });

  factory WcfmProductPolicyData.fromJson(Map<String, dynamic> json) =>
      WcfmProductPolicyData(
        shippingPolicyHeading: json["shipping_policy_heading"],
        shippingPolicy: json["shipping_policy"],
        refundPolicyHeading: json["refund_policy_heading"],
        refundPolicy: json["refund_policy"],
        cancellationPolicyHeading: json["cancellation_policy_heading"],
        cancellationPolicy: json["cancellation_policy"],
        visible: json["visible"],
        tabTitle: json["tab_title"],
      );

  Map<String, dynamic> toJson() => {
    "shipping_policy_heading": shippingPolicyHeading,
    "shipping_policy": shippingPolicy,
    "refund_policy_heading": refundPolicyHeading,
    "refund_policy": refundPolicy,
    "cancellation_policy_heading": cancellationPolicyHeading,
    "cancellation_policy": cancellationPolicy,
    "visible": visible,
    "tab_title": tabTitle,
  };
}

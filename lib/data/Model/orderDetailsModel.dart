// // To parse this JSON data, do
// //
// //     final orderDetailsModel = orderDetailsModelFromJson(jsonString);

// import 'dart:convert';

// OrderDetailsModel orderDetailsModelFromJson(String str) => OrderDetailsModel.fromJson(json.decode(str));

// String orderDetailsModelToJson(OrderDetailsModel data) => json.encode(data.toJson());

// class OrderDetailsModel {
//     int id;
//     int parentId;
//     String status;
//     String currency;
//     String version;
//     bool pricesIncludeTax;
//     DateTime dateCreated;
//     DateTime dateModified;
//     String discountTotal;
//     String discountTax;
//     String shippingTotal;
//     String shippingTax;
//     String cartTax;
//     String total;
//     String totalTax;
//     int customerId;
//     String orderKey;
//     Ing billing;
//     Ing shipping;
//     String paymentMethod;
//     String paymentMethodTitle;
//     String transactionId;
//     String customerIpAddress;
//     String customerUserAgent;
//     String createdVia;
//     String customerNote;
//     DateTime dateCompleted;
//     DateTime datePaid;
//     String cartHash;
//     String number;
//     List<OrderDetailsModelMetaDatum> metaData;
//     List<LineItem> lineItems;
//     List<dynamic> taxLines;
//     List<ShippingLine> shippingLines;
//     List<dynamic> feeLines;
//     List<dynamic> couponLines;
//     List<dynamic> refunds;
//     String paymentUrl;
//     bool isEditable;
//     bool needsPayment;
//     bool needsProcessing;
//     DateTime dateCreatedGmt;
//     DateTime dateModifiedGmt;
//     DateTime dateCompletedGmt;
//     DateTime datePaidGmt;
//     String featuredImageSrc;
//     List<dynamic> amsAcf;
//     String amsPaymentMethodTitle;
//     String orderCheckoutPaymentUrl;
//     String currencySymbol;
//     Links links;

//     OrderDetailsModel({
//         required this.id,
//         required this.parentId,
//         required this.status,
//         required this.currency,
//         required this.version,
//         required this.pricesIncludeTax,
//         required this.dateCreated,
//         required this.dateModified,
//         required this.discountTotal,
//         required this.discountTax,
//         required this.shippingTotal,
//         required this.shippingTax,
//         required this.cartTax,
//         required this.total,
//         required this.totalTax,
//         required this.customerId,
//         required this.orderKey,
//         required this.billing,
//         required this.shipping,
//         required this.paymentMethod,
//         required this.paymentMethodTitle,
//         required this.transactionId,
//         required this.customerIpAddress,
//         required this.customerUserAgent,
//         required this.createdVia,
//         required this.customerNote,
//         required this.dateCompleted,
//         required this.datePaid,
//         required this.cartHash,
//         required this.number,
//         required this.metaData,
//         required this.lineItems,
//         required this.taxLines,
//         required this.shippingLines,
//         required this.feeLines,
//         required this.couponLines,
//         required this.refunds,
//         required this.paymentUrl,
//         required this.isEditable,
//         required this.needsPayment,
//         required this.needsProcessing,
//         required this.dateCreatedGmt,
//         required this.dateModifiedGmt,
//         required this.dateCompletedGmt,
//         required this.datePaidGmt,
//         required this.featuredImageSrc,
//         required this.amsAcf,
//         required this.amsPaymentMethodTitle,
//         required this.orderCheckoutPaymentUrl,
//         required this.currencySymbol,
//         required this.links,
//     });

//     factory OrderDetailsModel.fromJson(Map<String, dynamic> json) => OrderDetailsModel(
//         id: json["id"],
//         parentId: json["parent_id"],
//         status: json["status"],
//         currency: json["currency"],
//         version: json["version"],
//         pricesIncludeTax: json["prices_include_tax"],
//         dateCreated: DateTime.parse(json["date_created"]),
//         dateModified: DateTime.parse(json["date_modified"]),
//         discountTotal: json["discount_total"],
//         discountTax: json["discount_tax"],
//         shippingTotal: json["shipping_total"],
//         shippingTax: json["shipping_tax"],
//         cartTax: json["cart_tax"],
//         total: json["total"],
//         totalTax: json["total_tax"],
//         customerId: json["customer_id"],
//         orderKey: json["order_key"],
//         billing: Ing.fromJson(json["billing"]),
//         shipping: Ing.fromJson(json["shipping"]),
//         paymentMethod: json["payment_method"],
//         paymentMethodTitle: json["payment_method_title"],
//         transactionId: json["transaction_id"],
//         customerIpAddress: json["customer_ip_address"],
//         customerUserAgent: json["customer_user_agent"],
//         createdVia: json["created_via"],
//         customerNote: json["customer_note"],
//         dateCompleted: DateTime.parse(json["date_completed"]),
//         datePaid: DateTime.parse(json["date_paid"]),
//         cartHash: json["cart_hash"],
//         number: json["number"],
//         metaData: List<OrderDetailsModelMetaDatum>.from(json["meta_data"].map((x) => OrderDetailsModelMetaDatum.fromJson(x))),
//         lineItems: List<LineItem>.from(json["line_items"].map((x) => LineItem.fromJson(x))),
//         taxLines: List<dynamic>.from(json["tax_lines"].map((x) => x)),
//         shippingLines: List<ShippingLine>.from(json["shipping_lines"].map((x) => ShippingLine.fromJson(x))),
//         feeLines: List<dynamic>.from(json["fee_lines"].map((x) => x)),
//         couponLines: List<dynamic>.from(json["coupon_lines"].map((x) => x)),
//         refunds: List<dynamic>.from(json["refunds"].map((x) => x)),
//         paymentUrl: json["payment_url"],
//         isEditable: json["is_editable"],
//         needsPayment: json["needs_payment"],
//         needsProcessing: json["needs_processing"],
//         dateCreatedGmt: DateTime.parse(json["date_created_gmt"]),
//         dateModifiedGmt: DateTime.parse(json["date_modified_gmt"]),
//         dateCompletedGmt: DateTime.parse(json["date_completed_gmt"]),
//         datePaidGmt: DateTime.parse(json["date_paid_gmt"]),
//         featuredImageSrc: json["featured_image_src"],
//         amsAcf: List<dynamic>.from(json["ams_acf"].map((x) => x)),
//         amsPaymentMethodTitle: json["ams_payment_method_title"],
//         orderCheckoutPaymentUrl: json["order_checkout_payment_url"],
//         currencySymbol: json["currency_symbol"],
//         links: Links.fromJson(json["_links"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "parent_id": parentId,
//         "status": status,
//         "currency": currency,
//         "version": version,
//         "prices_include_tax": pricesIncludeTax,
//         "date_created": dateCreated.toIso8601String(),
//         "date_modified": dateModified.toIso8601String(),
//         "discount_total": discountTotal,
//         "discount_tax": discountTax,
//         "shipping_total": shippingTotal,
//         "shipping_tax": shippingTax,
//         "cart_tax": cartTax,
//         "total": total,
//         "total_tax": totalTax,
//         "customer_id": customerId,
//         "order_key": orderKey,
//         "billing": billing.toJson(),
//         "shipping": shipping.toJson(),
//         "payment_method": paymentMethod,
//         "payment_method_title": paymentMethodTitle,
//         "transaction_id": transactionId,
//         "customer_ip_address": customerIpAddress,
//         "customer_user_agent": customerUserAgent,
//         "created_via": createdVia,
//         "customer_note": customerNote,
//         "date_completed": dateCompleted.toIso8601String(),
//         "date_paid": datePaid.toIso8601String(),
//         "cart_hash": cartHash,
//         "number": number,
//         "meta_data": List<dynamic>.from(metaData.map((x) => x.toJson())),
//         "line_items": List<dynamic>.from(lineItems.map((x) => x.toJson())),
//         "tax_lines": List<dynamic>.from(taxLines.map((x) => x)),
//         "shipping_lines": List<dynamic>.from(shippingLines.map((x) => x.toJson())),
//         "fee_lines": List<dynamic>.from(feeLines.map((x) => x)),
//         "coupon_lines": List<dynamic>.from(couponLines.map((x) => x)),
//         "refunds": List<dynamic>.from(refunds.map((x) => x)),
//         "payment_url": paymentUrl,
//         "is_editable": isEditable,
//         "needs_payment": needsPayment,
//         "needs_processing": needsProcessing,
//         "date_created_gmt": dateCreatedGmt.toIso8601String(),
//         "date_modified_gmt": dateModifiedGmt.toIso8601String(),
//         "date_completed_gmt": dateCompletedGmt.toIso8601String(),
//         "date_paid_gmt": datePaidGmt.toIso8601String(),
//         "featured_image_src": featuredImageSrc,
//         "ams_acf": List<dynamic>.from(amsAcf.map((x) => x)),
//         "ams_payment_method_title": amsPaymentMethodTitle,
//         "order_checkout_payment_url": orderCheckoutPaymentUrl,
//         "currency_symbol": currencySymbol,
//         "_links": links.toJson(),
//     };
// }

// class Ing {
//     String firstName;
//     String lastName;
//     String company;
//     String address1;
//     String address2;
//     String city;
//     String state;
//     String postcode;
//     String country;
//     String? email;
//     String phone;

//     Ing({
//         required this.firstName,
//         required this.lastName,
//         required this.company,
//         required this.address1,
//         required this.address2,
//         required this.city,
//         required this.state,
//         required this.postcode,
//         required this.country,
//         this.email,
//         required this.phone,
//     });

//     factory Ing.fromJson(Map<String, dynamic> json) => Ing(
//         firstName: json["first_name"],
//         lastName: json["last_name"],
//         company: json["company"],
//         address1: json["address_1"],
//         address2: json["address_2"],
//         city: json["city"],
//         state: json["state"],
//         postcode: json["postcode"],
//         country: json["country"],
//         email: json["email"],
//         phone: json["phone"],
//     );

//     Map<String, dynamic> toJson() => {
//         "first_name": firstName,
//         "last_name": lastName,
//         "company": company,
//         "address_1": address1,
//         "address_2": address2,
//         "city": city,
//         "state": state,
//         "postcode": postcode,
//         "country": country,
//         "email": email,
//         "phone": phone,
//     };
// }

// class LineItem {
//     int id;
//     String name;
//     int productId;
//     int variationId;
//     int quantity;
//     String taxClass;
//     String subtotal;
//     String subtotalTax;
//     String total;
//     String totalTax;
//     List<dynamic> taxes;
//     List<LineItemMetaDatum> metaData;
//     dynamic sku;
//     dynamic globalUniqueId;
//     int price;
//     Image image;
//     dynamic parentName;
//     dynamic amsOrderThumbnail;

//     LineItem({
//         required this.id,
//         required this.name,
//         required this.productId,
//         required this.variationId,
//         required this.quantity,
//         required this.taxClass,
//         required this.subtotal,
//         required this.subtotalTax,
//         required this.total,
//         required this.totalTax,
//         required this.taxes,
//         required this.metaData,
//         required this.sku,
//         required this.globalUniqueId,
//         required this.price,
//         required this.image,
//         required this.parentName,
//         required this.amsOrderThumbnail,
//     });

//     factory LineItem.fromJson(Map<String, dynamic> json) => LineItem(
//         id: json["id"],
//         name: json["name"],
//         productId: json["product_id"],
//         variationId: json["variation_id"],
//         quantity: json["quantity"],
//         taxClass: json["tax_class"],
//         subtotal: json["subtotal"],
//         subtotalTax: json["subtotal_tax"],
//         total: json["total"],
//         totalTax: json["total_tax"],
//         taxes: List<dynamic>.from(json["taxes"].map((x) => x)),
//         metaData: List<LineItemMetaDatum>.from(json["meta_data"].map((x) => LineItemMetaDatum.fromJson(x))),
//         sku: json["sku"],
//         globalUniqueId: json["global_unique_id"],
//         price: json["price"],
//         image: Image.fromJson(json["image"]),
//         parentName: json["parent_name"],
//         amsOrderThumbnail: json["ams_order_thumbnail"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "product_id": productId,
//         "variation_id": variationId,
//         "quantity": quantity,
//         "tax_class": taxClass,
//         "subtotal": subtotal,
//         "subtotal_tax": subtotalTax,
//         "total": total,
//         "total_tax": totalTax,
//         "taxes": List<dynamic>.from(taxes.map((x) => x)),
//         "meta_data": List<dynamic>.from(metaData.map((x) => x.toJson())),
//         "sku": sku,
//         "global_unique_id": globalUniqueId,
//         "price": price,
//         "image": image.toJson(),
//         "parent_name": parentName,
//         "ams_order_thumbnail": amsOrderThumbnail,
//     };
// }

// class Image {
//     int id;
//     String src;

//     Image({
//         required this.id,
//         required this.src,
//     });

//     factory Image.fromJson(Map<String, dynamic> json) => Image(
//         id: json["id"],
//         src: json["src"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "src": src,
//     };
// }

// class LineItemMetaDatum {
//     int id;
//     String key;
//     String value;
//     String displayKey;
//     String displayValue;

//     LineItemMetaDatum({
//         required this.id,
//         required this.key,
//         required this.value,
//         required this.displayKey,
//         required this.displayValue,
//     });

//     factory LineItemMetaDatum.fromJson(Map<String, dynamic> json) => LineItemMetaDatum(
//         id: json["id"],
//         key: json["key"],
//         value: json["value"],
//         displayKey: json["display_key"],
//         displayValue: json["display_value"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "key": key,
//         "value": value,
//         "display_key": displayKey,
//         "display_value": displayValue,
//     };
// }

// class Links {
//     List<Self> self;
//     List<Collection> collection;
//     List<EmailTemplate> emailTemplates;
//     List<Collection> customer;

//     Links({
//         required this.self,
//         required this.collection,
//         required this.emailTemplates,
//         required this.customer,
//     });

//     factory Links.fromJson(Map<String, dynamic> json) => Links(
//         self: List<Self>.from(json["self"].map((x) => Self.fromJson(x))),
//         collection: List<Collection>.from(json["collection"].map((x) => Collection.fromJson(x))),
//         emailTemplates: List<EmailTemplate>.from(json["email_templates"].map((x) => EmailTemplate.fromJson(x))),
//         customer: List<Collection>.from(json["customer"].map((x) => Collection.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "self": List<dynamic>.from(self.map((x) => x.toJson())),
//         "collection": List<dynamic>.from(collection.map((x) => x.toJson())),
//         "email_templates": List<dynamic>.from(emailTemplates.map((x) => x.toJson())),
//         "customer": List<dynamic>.from(customer.map((x) => x.toJson())),
//     };
// }

// class Collection {
//     String href;

//     Collection({
//         required this.href,
//     });

//     factory Collection.fromJson(Map<String, dynamic> json) => Collection(
//         href: json["href"],
//     );

//     Map<String, dynamic> toJson() => {
//         "href": href,
//     };
// }

// class EmailTemplate {
//     bool embeddable;
//     String href;

//     EmailTemplate({
//         required this.embeddable,
//         required this.href,
//     });

//     factory EmailTemplate.fromJson(Map<String, dynamic> json) => EmailTemplate(
//         embeddable: json["embeddable"],
//         href: json["href"],
//     );

//     Map<String, dynamic> toJson() => {
//         "embeddable": embeddable,
//         "href": href,
//     };
// }

// class Self {
//     String href;
//     TargetHints targetHints;

//     Self({
//         required this.href,
//         required this.targetHints,
//     });

//     factory Self.fromJson(Map<String, dynamic> json) => Self(
//         href: json["href"],
//         targetHints: TargetHints.fromJson(json["targetHints"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "href": href,
//         "targetHints": targetHints.toJson(),
//     };
// }

// class TargetHints {
//     List<String> allow;

//     TargetHints({
//         required this.allow,
//     });

//     factory TargetHints.fromJson(Map<String, dynamic> json) => TargetHints(
//         allow: List<String>.from(json["allow"].map((x) => x)),
//     );

//     Map<String, dynamic> toJson() => {
//         "allow": List<dynamic>.from(allow.map((x) => x)),
//     };
// }

// class OrderDetailsModelMetaDatum {
//     int id;
//     String key;
//     String value;

//     OrderDetailsModelMetaDatum({
//         required this.id,
//         required this.key,
//         required this.value,
//     });

//     factory OrderDetailsModelMetaDatum.fromJson(Map<String, dynamic> json) => OrderDetailsModelMetaDatum(
//         id: json["id"],
//         key: json["key"],
//         value: json["value"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "key": key,
//         "value": value,
//     };
// }

// class ShippingLine {
//     int id;
//     String methodTitle;
//     String methodId;
//     String instanceId;
//     String total;
//     String totalTax;
//     List<dynamic> taxes;
//     String taxStatus;
//     List<dynamic> metaData;

//     ShippingLine({
//         required this.id,
//         required this.methodTitle,
//         required this.methodId,
//         required this.instanceId,
//         required this.total,
//         required this.totalTax,
//         required this.taxes,
//         required this.taxStatus,
//         required this.metaData,
//     });

//     factory ShippingLine.fromJson(Map<String, dynamic> json) => ShippingLine(
//         id: json["id"],
//         methodTitle: json["method_title"],
//         methodId: json["method_id"],
//         instanceId: json["instance_id"],
//         total: json["total"],
//         totalTax: json["total_tax"],
//         taxes: List<dynamic>.from(json["taxes"].map((x) => x)),
//         taxStatus: json["tax_status"],
//         metaData: List<dynamic>.from(json["meta_data"].map((x) => x)),
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "method_title": methodTitle,
//         "method_id": methodId,
//         "instance_id": instanceId,
//         "total": total,
//         "total_tax": totalTax,
//         "taxes": List<dynamic>.from(taxes.map((x) => x)),
//         "tax_status": taxStatus,
//         "meta_data": List<dynamic>.from(metaData.map((x) => x)),
//     };
// }
class OrderDetailsModel {
  final int id;
  final int parentId;
  final String status;
  final String currency;
  final String version;
  final bool pricesIncludeTax;
  final DateTime dateCreated;
  final DateTime dateModified;
  final String discountTotal;
  final String discountTax;
  final String shippingTotal;
  final String shippingTax;
  final String cartTax;
  final String total;
  final String totalTax;
  final int customerId;
  final String orderKey;
  final Billing billing;
  final Shipping shipping;
  final String paymentMethod;
  final String paymentMethodTitle;
  final String transactionId;
  final DateTime datePaid;
  final DateTime dateCompleted;
  final String cartHash;
  final List<MetaDatum> metaData;
  final List<LineItem> lineItems;

  OrderDetailsModel({
    required this.id,
    required this.parentId,
    required this.status,
    required this.currency,
    required this.version,
    required this.pricesIncludeTax,
    required this.dateCreated,
    required this.dateModified,
    required this.discountTotal,
    required this.discountTax,
    required this.shippingTotal,
    required this.shippingTax,
    required this.cartTax,
    required this.total,
    required this.totalTax,
    required this.customerId,
    required this.orderKey,
    required this.billing,
    required this.shipping,
    required this.paymentMethod,
    required this.paymentMethodTitle,
    required this.transactionId,
    required this.datePaid,
    required this.dateCompleted,
    required this.cartHash,
    required this.metaData,
    required this.lineItems,
  });

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    final metaList = (json["meta_data"] as List? ?? [])
        .map((x) => MetaDatum.fromJson(x))
        .toList();

    return OrderDetailsModel(
      id: json["id"] ?? 0,
      parentId: json["parent_id"] ?? 0,
      status: json["status"] ?? "",
      currency: json["currency"] ?? "",
      version: json["version"] ?? "",
      pricesIncludeTax: json["prices_include_tax"] ?? false,
      dateCreated: DateTime.tryParse(json["date_created"] ?? "") ?? DateTime(1970),
      dateModified: DateTime.tryParse(json["date_modified"] ?? "") ?? DateTime(1970),
      discountTotal: json["discount_total"] ?? "",
      discountTax: json["discount_tax"] ?? "",
      shippingTotal: json["shipping_total"] ?? "",
      shippingTax: json["shipping_tax"] ?? "",
      cartTax: json["cart_tax"] ?? "",
      total: json["total"] ?? "",
      totalTax: json["total_tax"] ?? "",
      customerId: json["customer_id"] ?? 0,
      orderKey: json["order_key"] ?? "",
      billing: Billing.fromJson(json["billing"] ?? {}, metaList),
      shipping: Shipping.fromJson(json["shipping"] ?? {}, metaList),
      paymentMethod: json["payment_method"] ?? "",
      paymentMethodTitle: json["payment_method_title"] ?? "",
      transactionId: json["transaction_id"] ?? "",
      datePaid: DateTime.tryParse(json["date_paid"] ?? "") ?? DateTime(1970),
      dateCompleted: DateTime.tryParse(json["date_completed"] ?? "") ?? DateTime(1970),
      cartHash: json["cart_hash"] ?? "",
      metaData: metaList,
      lineItems: (json["line_items"] as List? ?? [])
          .map((x) => LineItem.fromJson(x))
          .toList(),
    );
  }
}

class Billing extends Ing {
  Billing({
    super.firstName,
    super.lastName,
    super.company,
    super.address1,
    super.address2,
    super.city,
    super.state,
    super.postcode,
    super.country,
    super.email,
    super.phone,
  });

  factory Billing.fromJson(Map<String, dynamic> json, List<MetaDatum> metaData) {
    if ((json["first_name"] ?? "").isEmpty && (json["last_name"] ?? "").isEmpty) {
      try {
        final meta = metaData.firstWhere((m) => m.key == "_billing_0");
        if (meta.value is Map<String, dynamic>) {
          return Billing.fromJson(meta.value, metaData);
        }
      } catch (_) {}
    }
    return Billing(
      firstName: json["first_name"] ?? "",
      lastName: json["last_name"] ?? "",
      company: json["company"] ?? "",
      address1: json["address_1"] ?? "",
      address2: json["address_2"] ?? "",
      city: json["city"] ?? "",
      state: json["state"] ?? "",
      postcode: json["postcode"] ?? "",
      country: json["country"] ?? "",
      email: json["email"] ?? "",
      phone: json["phone"] ?? "",
    );
  }
}

class Shipping extends Ing {
  Shipping({
    super.firstName,
    super.lastName,
    super.company,
    super.address1,
    super.address2,
    super.city,
    super.state,
    super.postcode,
    super.country,
    super.email,
    super.phone,
  });

  factory Shipping.fromJson(Map<String, dynamic> json, List<MetaDatum> metaData) {
    if ((json["first_name"] ?? "").isEmpty && (json["last_name"] ?? "").isEmpty) {
      try {
        final meta = metaData.firstWhere((m) => m.key == "_shipping_0");
        if (meta.value is Map<String, dynamic>) {
          return Shipping.fromJson(meta.value, metaData);
        }
      } catch (_) {}
    }
    return Shipping(
      firstName: json["first_name"] ?? "",
      lastName: json["last_name"] ?? "",
      company: json["company"] ?? "",
      address1: json["address_1"] ?? "",
      address2: json["address_2"] ?? "",
      city: json["city"] ?? "",
      state: json["state"] ?? "",
      postcode: json["postcode"] ?? "",
      country: json["country"] ?? "",
      email: json["email"] ?? "",
      phone: json["phone"] ?? "",
    );
  }
}

class Ing {
  final String? firstName;
  final String? lastName;
  final String? company;
  final String? address1;
  final String? address2;
  final String? city;
  final String? state;
  final String? postcode;
  final String? country;
  final String? email;
  final String? phone;

  Ing({
    this.firstName,
    this.lastName,
    this.company,
    this.address1,
    this.address2,
    this.city,
    this.state,
    this.postcode,
    this.country,
    this.email,
    this.phone,
  });

  Map<String, dynamic> toJson() => {
        "first_name": firstName ?? "",
        "last_name": lastName ?? "",
        "company": company ?? "",
        "address_1": address1 ?? "",
        "address_2": address2 ?? "",
        "city": city ?? "",
        "state": state ?? "",
        "postcode": postcode ?? "",
        "country": country ?? "",
        "email": email ?? "",
        "phone": phone ?? "",
      };
}

class LineItem {
  final int id;
  final String name;
  final int productId;
  final int variationId;
  final int quantity;
  final String taxClass;
  final String subtotal;
  final String subtotalTax;
  final String total;
  final String totalTax;
  final List<dynamic> taxes;
  final List<dynamic> metaData;
  final String sku;
  final int price;
  final dynamic parentName;
  final ImageClass? image;
  final String? amsOrderThumbnail;

  LineItem({
    required this.id,
    required this.name,
    required this.productId,
    required this.variationId,
    required this.quantity,
    required this.taxClass,
    required this.subtotal,
    required this.subtotalTax,
    required this.total,
    required this.totalTax,
    required this.taxes,
    required this.metaData,
    required this.sku,
    required this.price,
    required this.parentName,
    this.image,
    this.amsOrderThumbnail,
  });

  factory LineItem.fromJson(Map<String, dynamic> json) => LineItem(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        productId: json["product_id"] ?? 0,
        variationId: json["variation_id"] ?? 0,
        quantity: json["quantity"] ?? 0,
        taxClass: json["tax_class"] ?? "",
        subtotal: json["subtotal"] ?? "",
        subtotalTax: json["subtotal_tax"] ?? "",
        total: json["total"] ?? "",
        totalTax: json["total_tax"] ?? "",
        taxes: List<dynamic>.from(json["taxes"] ?? []),
        metaData: List<dynamic>.from(json["meta_data"] ?? []),
        sku: json["sku"] ?? "",
        price: json["price"] ?? 0,
        parentName: json["parent_name"],
        image: json["image"] != null ? ImageClass.fromJson(json["image"]) : null,
        amsOrderThumbnail: json["ams_order_thumbnail"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "product_id": productId,
        "variation_id": variationId,
        "quantity": quantity,
        "tax_class": taxClass,
        "subtotal": subtotal,
        "subtotal_tax": subtotalTax,
        "total": total,
        "total_tax": totalTax,
        "taxes": taxes,
        "meta_data": metaData,
        "sku": sku,
        "price": price,
        "parent_name": parentName,
        "image": image?.toJson(),
        "ams_order_thumbnail": amsOrderThumbnail,
      };
}

class ImageClass {
  final String id;
  final String src;

  ImageClass({
    required this.id,
    required this.src,
  });

  factory ImageClass.fromJson(Map<String, dynamic> json) => ImageClass(
        id: json["id"]?.toString() ?? "",
        src: json["src"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "src": src,
      };
}

class MetaDatum {
  final int id;
  final String key;
  final dynamic value;

  MetaDatum({
    required this.id,
    required this.key,
    required this.value,
  });

  factory MetaDatum.fromJson(Map<String, dynamic> json) => MetaDatum(
        id: json["id"] ?? 0,
        key: json["key"] ?? "",
        value: json["value"],
      );
}

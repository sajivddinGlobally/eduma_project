// // To parse this JSON data, do
// //

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
      dateCreated:
          DateTime.tryParse(json["date_created"] ?? "") ?? DateTime(1970),
      dateModified:
          DateTime.tryParse(json["date_modified"] ?? "") ?? DateTime(1970),
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
      dateCompleted:
          DateTime.tryParse(json["date_completed"] ?? "") ?? DateTime(1970),
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

  factory Billing.fromJson(
    Map<String, dynamic> json,
    List<MetaDatum> metaData,
  ) {
    if ((json["first_name"] ?? "").isEmpty &&
        (json["last_name"] ?? "").isEmpty) {
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

  factory Shipping.fromJson(
    Map<String, dynamic> json,
    List<MetaDatum> metaData,
  ) {
    if ((json["first_name"] ?? "").isEmpty &&
        (json["last_name"] ?? "").isEmpty) {
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

  ImageClass({required this.id, required this.src});

  factory ImageClass.fromJson(Map<String, dynamic> json) =>
      ImageClass(id: json["id"]?.toString() ?? "", src: json["src"] ?? "");

  Map<String, dynamic> toJson() => {"id": id, "src": src};
}

class MetaDatum {
  final int id;
  final String key;
  final dynamic value;

  MetaDatum({required this.id, required this.key, required this.value});

  factory MetaDatum.fromJson(Map<String, dynamic> json) => MetaDatum(
    id: json["id"] ?? 0,
    key: json["key"] ?? "",
    value: json["value"],
  );
}

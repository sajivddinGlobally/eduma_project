// To parse this JSON data, do
//
//     final createBodyModel = createBodyModelFromJson(jsonString);

import 'dart:convert';

CreateBodyModel createBodyModelFromJson(String str) => CreateBodyModel.fromJson(json.decode(str));

String createBodyModelToJson(CreateBodyModel data) => json.encode(data.toJson());

class CreateBodyModel {
    List<Cart> cart;
    Billing billing;

    CreateBodyModel({
        required this.cart,
        required this.billing,
    });

    factory CreateBodyModel.fromJson(Map<String, dynamic> json) => CreateBodyModel(
        cart: List<Cart>.from(json["cart"].map((x) => Cart.fromJson(x))),
        billing: Billing.fromJson(json["billing"]),
    );

    Map<String, dynamic> toJson() => {
        "cart": List<dynamic>.from(cart.map((x) => x.toJson())),
        "billing": billing.toJson(),
    };
}

class Billing {
    String firstName;
    String lastName;
    String address1;
    String city;
    String postcode;
    String phone;
    String email;

    Billing({
        required this.firstName,
        required this.lastName,
        required this.address1,
        required this.city,
        required this.postcode,
        required this.phone,
        required this.email,
    });

    factory Billing.fromJson(Map<String, dynamic> json) => Billing(
        firstName: json["first_name"],
        lastName: json["last_name"],
        address1: json["address_1"],
        city: json["city"],
        postcode: json["postcode"],
        phone: json["phone"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "address_1": address1,
        "city": city,
        "postcode": postcode,
        "phone": phone,
        "email": email,
    };
}

class Cart {
    int productId;
    int quantity;

    Cart({
        required this.productId,
        required this.quantity,
    });

    factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        productId: json["product_id"],
        quantity: json["quantity"],
    );

    Map<String, dynamic> toJson() => {
        "product_id": productId,
        "quantity": quantity,
    };
}

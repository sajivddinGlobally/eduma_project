// To parse this JSON data, do
//
//     final editAddressResModel = editAddressResModelFromJson(jsonString);

import 'dart:convert';

EditAddressResModel editAddressResModelFromJson(String str) => EditAddressResModel.fromJson(json.decode(str));

String editAddressResModelToJson(EditAddressResModel data) => json.encode(data.toJson());

class EditAddressResModel {
    String orderId;
    String amount;
    String currency;
    String receipt;
    String razorpayKey;
    int wcOrderId;
    User user;
    Ing billing;
    Ing shipping;
    bool addressEditable;

    EditAddressResModel({
        required this.orderId,
        required this.amount,
        required this.currency,
        required this.receipt,
        required this.razorpayKey,
        required this.wcOrderId,
        required this.user,
        required this.billing,
        required this.shipping,
        required this.addressEditable,
    });

    factory EditAddressResModel.fromJson(Map<String, dynamic> json) => EditAddressResModel(
        orderId: json["order_id"],
        amount: json["amount"],
        currency: json["currency"],
        receipt: json["receipt"],
        razorpayKey: json["razorpay_key"],
        wcOrderId: json["wc_order_id"],
        user: User.fromJson(json["user"]),
        billing: Ing.fromJson(json["billing"]),
        shipping: Ing.fromJson(json["shipping"]),
        addressEditable: json["address_editable"],
    );

    Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "amount": amount,
        "currency": currency,
        "receipt": receipt,
        "razorpay_key": razorpayKey,
        "wc_order_id": wcOrderId,
        "user": user.toJson(),
        "billing": billing.toJson(),
        "shipping": shipping.toJson(),
        "address_editable": addressEditable,
    };
}

class Ing {
    String firstName;
    String lastName;
    String address1;
    String city;
    String state;
    String postcode;
    String country;
    String? phone;
    String? email;

    Ing({
        required this.firstName,
        required this.lastName,
        required this.address1,
        required this.city,
        required this.state,
        required this.postcode,
        required this.country,
        this.phone,
        this.email,
    });

    factory Ing.fromJson(Map<String, dynamic> json) => Ing(
        firstName: json["first_name"],
        lastName: json["last_name"],
        address1: json["address_1"],
        city: json["city"],
        state: json["state"],
        postcode: json["postcode"],
        country: json["country"],
        phone: json["phone"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "address_1": address1,
        "city": city,
        "state": state,
        "postcode": postcode,
        "country": country,
        "phone": phone,
        "email": email,
    };
}

class User {
    String name;
    String email;
    String contact;

    User({
        required this.name,
        required this.email,
        required this.contact,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        email: json["email"],
        contact: json["contact"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "contact": contact,
    };
}

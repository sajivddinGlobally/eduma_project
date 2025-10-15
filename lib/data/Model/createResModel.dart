// To parse this JSON data, do
//
//     final createResModel = createResModelFromJson(jsonString);

import 'dart:convert';

CreateResModel createResModelFromJson(String str) =>
    CreateResModel.fromJson(json.decode(str));

String createResModelToJson(CreateResModel data) => json.encode(data.toJson());

class CreateResModel {
  String orderId;
  String amount;
  String currency;
  String receipt;
  String razorpayKey;
  int wcOrderId;
  User user;
  Billing billing;

  CreateResModel({
    required this.orderId,
    required this.amount,
    required this.currency,
    required this.receipt,
    required this.razorpayKey,
    required this.wcOrderId,
    required this.user,
    required this.billing,
  });

  factory CreateResModel.fromJson(Map<String, dynamic> json) => CreateResModel(
    orderId: json["order_id"],
    amount: json["amount"],
    currency: json["currency"],
    receipt: json["receipt"],
    razorpayKey: json["razorpay_key"],
    wcOrderId: json["wc_order_id"],
    user: User.fromJson(json["user"]),
    billing: Billing.fromJson(json["billing"]),
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
  };
}

class Billing {
  String firstName;
  String lastName;
  String address1;
  String city;
  String postcode;
  String? phone;
  String? email;

  Billing({
    required this.firstName,
    required this.lastName,
    required this.address1,
    required this.city,
    required this.postcode,
    this.phone,
    this.email,
  });

  factory Billing.fromJson(Map<String, dynamic> json) => Billing(
    firstName: json["first_name"],
    lastName: json["last_name"],
    address1: json["address_1"],
    city: json["city"],
    postcode: json["postcode"],
    phone: json["phone"].toString(),
    email: json["email"].toString(),
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

class User {
  String name;
  String email;
  String contact;

  User({required this.name, required this.email, required this.contact});

  factory User.fromJson(Map<String, dynamic> json) =>
      User(name: json["name"], email: json["email"], contact: json["contact"]);

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "contact": contact,
  };
}

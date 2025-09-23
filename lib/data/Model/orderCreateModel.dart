// To parse this JSON data, do
//
//     final orderCreateModel = orderCreateModelFromJson(jsonString);

import 'dart:convert';

OrderCreateModel orderCreateModelFromJson(String str) =>
    OrderCreateModel.fromJson(json.decode(str));

String orderCreateModelToJson(OrderCreateModel data) =>
    json.encode(data.toJson());

class OrderCreateModel {
  String orderId;
  String amount;
  String currency;
  String receipt;
  String razorpayKey;
  int wcOrderId;
  User user;

  OrderCreateModel({
    required this.orderId,
    required this.amount,
    required this.currency,
    required this.receipt,
    required this.razorpayKey,
    required this.wcOrderId,
    required this.user,
  });

  factory OrderCreateModel.fromJson(Map<String, dynamic> json) =>
      OrderCreateModel(
        orderId: json["order_id"],
        amount: json["amount"],
        currency: json["currency"],
        receipt: json["receipt"],
        razorpayKey: json["razorpay_key"],
        wcOrderId: json["wc_order_id"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
    "order_id": orderId,
    "amount": amount,
    "currency": currency,
    "receipt": receipt,
    "razorpay_key": razorpayKey,
    "wc_order_id": wcOrderId,
    "user": user.toJson(),
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

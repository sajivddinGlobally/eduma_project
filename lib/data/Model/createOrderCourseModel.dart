// To parse this JSON data, do
//
//     final createOrderCourseResModel = createOrderCourseResModelFromJson(jsonString);

import 'dart:convert';

CreateOrderCourseResModel createOrderCourseResModelFromJson(String str) => CreateOrderCourseResModel.fromJson(json.decode(str));

String createOrderCourseResModelToJson(CreateOrderCourseResModel data) => json.encode(data.toJson());

class CreateOrderCourseResModel {
    String orderId;
    int amount;
    String currency;
    String receipt;
    String razorpayKey;
    int tutorOrderId;
    User user;
    int courseId;

    CreateOrderCourseResModel({
        required this.orderId,
        required this.amount,
        required this.currency,
        required this.receipt,
        required this.razorpayKey,
        required this.tutorOrderId,
        required this.user,
        required this.courseId,
    });

    factory CreateOrderCourseResModel.fromJson(Map<String, dynamic> json) => CreateOrderCourseResModel(
        orderId: json["order_id"],
        amount: json["amount"],
        currency: json["currency"],
        receipt: json["receipt"],
        razorpayKey: json["razorpay_key"],
        tutorOrderId: json["tutor_order_id"],
        user: User.fromJson(json["user"]),
        courseId: json["course_id"],
    );

    Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "amount": amount,
        "currency": currency,
        "receipt": receipt,
        "razorpay_key": razorpayKey,
        "tutor_order_id": tutorOrderId,
        "user": user.toJson(),
        "course_id": courseId,
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

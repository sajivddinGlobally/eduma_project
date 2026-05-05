// To parse this JSON data, do
//
//     final applyCuponResModel = applyCuponResModelFromJson(jsonString);

import 'dart:convert';

ApplyCuponResModel applyCuponResModelFromJson(String str) =>
    ApplyCuponResModel.fromJson(json.decode(str));

String applyCuponResModelToJson(ApplyCuponResModel data) =>
    json.encode(data.toJson());

class ApplyCuponResModel {
  bool success;
  String couponCode;
  num discount;
  String discountType;
  int discountValue;
  String discountLabel;
  String message;

  ApplyCuponResModel({
    required this.success,
    required this.couponCode,
    required this.discount,
    required this.discountType,
    required this.discountValue,
    required this.discountLabel,
    required this.message,
  });

  factory ApplyCuponResModel.fromJson(Map<String, dynamic> json) =>
      ApplyCuponResModel(
        success: json["success"],
        couponCode: json["coupon_code"],
        discount: json["discount"] ?? 0,
        discountType: json["discount_type"],
        discountValue: json["discount_value"],
        discountLabel: json["discount_label"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "coupon_code": couponCode,
    "discount": discount,
    "discount_type": discountType,
    "discount_value": discountValue,
    "discount_label": discountLabel,
    "message": message,
  };
}

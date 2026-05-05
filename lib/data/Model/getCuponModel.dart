// To parse this JSON data, do
//
//     final getCuponModel = getCuponModelFromJson(jsonString);

import 'dart:convert';

GetCuponModel getCuponModelFromJson(String str) => GetCuponModel.fromJson(json.decode(str));

String getCuponModelToJson(GetCuponModel data) => json.encode(data.toJson());

class GetCuponModel {
    bool success;
    String couponCode;
    num discount;
    String discountType;
    String discountValue;
    String discountLabel;

    GetCuponModel({
        required this.success,
        required this.couponCode,
        required this.discount,
        required this.discountType,
        required this.discountValue,
        required this.discountLabel,
    });

    factory GetCuponModel.fromJson(Map<String, dynamic> json) => GetCuponModel(
        success: json["success"],
        couponCode: json["coupon_code"],
        discount: json["discount"] ?? 0,
        discountType: json["discount_type"],
        discountValue: json["discount_value"],
        discountLabel: json["discount_label"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "coupon_code": couponCode,
        "discount": discount,
        "discount_type": discountType,
        "discount_value": discountValue,
        "discount_label": discountLabel,
    };
}

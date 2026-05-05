// To parse this JSON data, do
//
//     final applyCuponBodyModel = applyCuponBodyModelFromJson(jsonString);

import 'dart:convert';

ApplyCuponBodyModel applyCuponBodyModelFromJson(String str) => ApplyCuponBodyModel.fromJson(json.decode(str));

String applyCuponBodyModelToJson(ApplyCuponBodyModel data) => json.encode(data.toJson());

class ApplyCuponBodyModel {
    String couponCode;

    ApplyCuponBodyModel({
        required this.couponCode,
    });

    factory ApplyCuponBodyModel.fromJson(Map<String, dynamic> json) => ApplyCuponBodyModel(
        couponCode: json["coupon_code"],
    );

    Map<String, dynamic> toJson() => {
        "coupon_code": couponCode,
    };
}

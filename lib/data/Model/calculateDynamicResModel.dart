// To parse this JSON data, do
//
//     final calculateDynamicResModel = calculateDynamicResModelFromJson(jsonString);

import 'dart:convert';

CalculateDynamicResModel calculateDynamicResModelFromJson(String str) => CalculateDynamicResModel.fromJson(json.decode(str));

String calculateDynamicResModelToJson(CalculateDynamicResModel data) => json.encode(data.toJson());

class CalculateDynamicResModel {
    String zone;
    int shippingCost;
    int subtotal;
    int discount20Percent;
    int finalTotal;

    CalculateDynamicResModel({
        required this.zone,
        required this.shippingCost,
        required this.subtotal,
        required this.discount20Percent,
        required this.finalTotal,
    });

    factory CalculateDynamicResModel.fromJson(Map<String, dynamic> json) => CalculateDynamicResModel(
        zone: json["zone"],
        shippingCost: json["shipping_cost"],
        subtotal: json["subtotal"],
        discount20Percent: json["discount_20_percent"],
        finalTotal: json["final_total"],
    );

    Map<String, dynamic> toJson() => {
        "zone": zone,
        "shipping_cost": shippingCost,
        "subtotal": subtotal,
        "discount_20_percent": discount20Percent,
        "final_total": finalTotal,
    };
}

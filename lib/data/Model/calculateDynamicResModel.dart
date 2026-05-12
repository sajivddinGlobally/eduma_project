// To parse this JSON data, do
//
//     final calculateDynamicResModel = calculateDynamicResModelFromJson(jsonString);

import 'dart:convert';

CalculateDynamicResModel calculateDynamicResModelFromJson(String str) =>
    CalculateDynamicResModel.fromJson(json.decode(str));

String calculateDynamicResModelToJson(CalculateDynamicResModel data) =>
    json.encode(data.toJson());

class CalculateDynamicResModel {
  String zone;
  num weight;
  int chargeableWeight;
  int ratePerKg;
  int shippingCost;
  int subtotal;
  int discount20Percent;
  int finalTotal;

  CalculateDynamicResModel({
    required this.zone,
    required this.weight,
    required this.chargeableWeight,
    required this.ratePerKg,
    required this.shippingCost,
    required this.subtotal,
    required this.discount20Percent,
    required this.finalTotal,
  });

  factory CalculateDynamicResModel.fromJson(Map<String, dynamic> json) =>
      CalculateDynamicResModel(
        zone: json["zone"],
        weight: json["weight"] is int
            ? json["weight"]
            : json["weight"] is double
            ? json["weight"]
            : double.tryParse(json["weight"]?.toString() ?? "0") ?? 0,
        chargeableWeight: json["chargeable_weight"],
        ratePerKg: json["rate_per_kg"],
        shippingCost: json["shipping_cost"],
        subtotal: json["subtotal"],
        discount20Percent: json["discount_20_percent"],
        finalTotal: json["final_total"],
      );

  Map<String, dynamic> toJson() => {
    "zone": zone,
    "weight": weight,
    "chargeable_weight": chargeableWeight,
    "rate_per_kg": ratePerKg,
    "shipping_cost": shippingCost,
    "subtotal": subtotal,
    "discount_20_percent": discount20Percent,
    "final_total": finalTotal,
  };
}

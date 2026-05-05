// To parse this JSON data, do
//
//     final calculateDynamicBodyModel = calculateDynamicBodyModelFromJson(jsonString);

import 'dart:convert';

CalculateDynamicBodyModel calculateDynamicBodyModelFromJson(String str) => CalculateDynamicBodyModel.fromJson(json.decode(str));

String calculateDynamicBodyModelToJson(CalculateDynamicBodyModel data) => json.encode(data.toJson());

class CalculateDynamicBodyModel {
    String? state;

    CalculateDynamicBodyModel({
        this.state,
    });

    factory CalculateDynamicBodyModel.fromJson(Map<String, dynamic> json) => CalculateDynamicBodyModel(
        state: json["state"],
    );

    Map<String, dynamic> toJson() => {
        "state": state,
    };
}

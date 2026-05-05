// To parse this JSON data, do
//
//     final razoarpayBodyModel = razoarpayBodyModelFromJson(jsonString);

import 'dart:convert';

RazoarpayBodyModel razoarpayBodyModelFromJson(String str) => RazoarpayBodyModel.fromJson(json.decode(str));

String razoarpayBodyModelToJson(RazoarpayBodyModel data) => json.encode(data.toJson());

class RazoarpayBodyModel {
    Shipping? shipping;

    RazoarpayBodyModel({
        this.shipping,
    });

    factory RazoarpayBodyModel.fromJson(Map<String, dynamic> json) => RazoarpayBodyModel(
        shipping: json["shipping"] == null ? null : Shipping.fromJson(json["shipping"]),
    );

    Map<String, dynamic> toJson() => {
        "shipping": shipping?.toJson(),
    };
}

class Shipping {
    String? state;

    Shipping({
        this.state,
    });

    factory Shipping.fromJson(Map<String, dynamic> json) => Shipping(
        state: json["state"],
    );

    Map<String, dynamic> toJson() => {
        "state": state,
    };
}

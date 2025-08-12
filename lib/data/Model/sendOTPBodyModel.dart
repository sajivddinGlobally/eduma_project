// To parse this JSON data, do
//
//     final sendOtpBodyModel = sendOtpBodyModelFromJson(jsonString);

import 'dart:convert';

SendOtpBodyModel sendOtpBodyModelFromJson(String str) => SendOtpBodyModel.fromJson(json.decode(str));

String sendOtpBodyModelToJson(SendOtpBodyModel data) => json.encode(data.toJson());

class SendOtpBodyModel {
    String email;

    SendOtpBodyModel({
        required this.email,
    });

    factory SendOtpBodyModel.fromJson(Map<String, dynamic> json) => SendOtpBodyModel(
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
    };
}

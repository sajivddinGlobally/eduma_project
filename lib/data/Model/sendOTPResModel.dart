// To parse this JSON data, do
//
//     final sendOtpResModel = sendOtpResModelFromJson(jsonString);

import 'dart:convert';

SendOtpResModel sendOtpResModelFromJson(String str) => SendOtpResModel.fromJson(json.decode(str));

String sendOtpResModelToJson(SendOtpResModel data) => json.encode(data.toJson());

class SendOtpResModel {
    bool success;
    String message;

    SendOtpResModel({
        required this.success,
        required this.message,
    });

    factory SendOtpResModel.fromJson(Map<String, dynamic> json) => SendOtpResModel(
        success: json["success"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
    };
}

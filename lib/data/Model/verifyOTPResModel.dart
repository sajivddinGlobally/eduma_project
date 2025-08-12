// To parse this JSON data, do
//
//     final verifyOtpResModel = verifyOtpResModelFromJson(jsonString);

import 'dart:convert';

VerifyOtpResModel verifyOtpResModelFromJson(String str) => VerifyOtpResModel.fromJson(json.decode(str));

String verifyOtpResModelToJson(VerifyOtpResModel data) => json.encode(data.toJson());

class VerifyOtpResModel {
    bool success;
    String message;
    String resetToken;

    VerifyOtpResModel({
        required this.success,
        required this.message,
        required this.resetToken,
    });

    factory VerifyOtpResModel.fromJson(Map<String, dynamic> json) => VerifyOtpResModel(
        success: json["success"],
        message: json["message"],
        resetToken: json["reset_token"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "reset_token": resetToken,
    };
}

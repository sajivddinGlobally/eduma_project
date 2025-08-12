// To parse this JSON data, do
//
//     final verifyOtpBodyModel = verifyOtpBodyModelFromJson(jsonString);

import 'dart:convert';

VerifyOtpBodyModel verifyOtpBodyModelFromJson(String str) => VerifyOtpBodyModel.fromJson(json.decode(str));

String verifyOtpBodyModelToJson(VerifyOtpBodyModel data) => json.encode(data.toJson());

class VerifyOtpBodyModel {
    String otp;

    VerifyOtpBodyModel({
        required this.otp,
    });

    factory VerifyOtpBodyModel.fromJson(Map<String, dynamic> json) => VerifyOtpBodyModel(
        otp: json["otp"],
    );

    Map<String, dynamic> toJson() => {
        "otp": otp,
    };
}

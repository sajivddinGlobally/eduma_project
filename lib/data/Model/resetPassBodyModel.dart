// To parse this JSON data, do
//
//     final resetPassBodyModel = resetPassBodyModelFromJson(jsonString);

import 'dart:convert';

ResetPassBodyModel resetPassBodyModelFromJson(String str) => ResetPassBodyModel.fromJson(json.decode(str));

String resetPassBodyModelToJson(ResetPassBodyModel data) => json.encode(data.toJson());

class ResetPassBodyModel {
    String resetToken;
    String newPassword;
    String confirmPassword;

    ResetPassBodyModel({
        required this.resetToken,
        required this.newPassword,
        required this.confirmPassword,
    });

    factory ResetPassBodyModel.fromJson(Map<String, dynamic> json) => ResetPassBodyModel(
        resetToken: json["reset_token"],
        newPassword: json["new_password"],
        confirmPassword: json["confirm_password"],
    );

    Map<String, dynamic> toJson() => {
        "reset_token": resetToken,
        "new_password": newPassword,
        "confirm_password": confirmPassword,
    };
}

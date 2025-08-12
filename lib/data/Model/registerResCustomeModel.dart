// To parse this JSON data, do
//
//     final registerResCustomeModel = registerResCustomeModelFromJson(jsonString);

import 'dart:convert';

RegisterResCustomeModel registerResCustomeModelFromJson(String str) => RegisterResCustomeModel.fromJson(json.decode(str));

String registerResCustomeModelToJson(RegisterResCustomeModel data) => json.encode(data.toJson());

class RegisterResCustomeModel {
    bool success;
    String message;
    int userId;

    RegisterResCustomeModel({
        required this.success,
        required this.message,
        required this.userId,
    });

    factory RegisterResCustomeModel.fromJson(Map<String, dynamic> json) => RegisterResCustomeModel(
        success: json["success"],
        message: json["message"],
        userId: json["user_id"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "user_id": userId,
    };
}

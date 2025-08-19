// To parse this JSON data, do
//
//     final registerResModel = registerResModelFromJson(jsonString);

import 'dart:convert';

RegisterResModel registerResModelFromJson(String str) => RegisterResModel.fromJson(json.decode(str));

String registerResModelToJson(RegisterResModel data) => json.encode(data.toJson());

class RegisterResModel {
    bool success;
    String message;
    int userId;

    RegisterResModel({
        required this.success,
        required this.message,
        required this.userId,
    });

    factory RegisterResModel.fromJson(Map<String, dynamic> json) => RegisterResModel(
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

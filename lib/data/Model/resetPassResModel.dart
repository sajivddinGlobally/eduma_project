// To parse this JSON data, do
//
//     final resetPassResModel = resetPassResModelFromJson(jsonString);

import 'dart:convert';

ResetPassResModel resetPassResModelFromJson(String str) => ResetPassResModel.fromJson(json.decode(str));

String resetPassResModelToJson(ResetPassResModel data) => json.encode(data.toJson());

class ResetPassResModel {
    String success;
    String message;

    ResetPassResModel({
        required this.success,
        required this.message,
    });

    factory ResetPassResModel.fromJson(Map<String, dynamic> json) => ResetPassResModel(
        success: json["success"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
    };
}

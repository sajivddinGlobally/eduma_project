// To parse this JSON data, do
//
//     final clearAllResModel = clearAllResModelFromJson(jsonString);

import 'dart:convert';

ClearAllResModel clearAllResModelFromJson(String str) => ClearAllResModel.fromJson(json.decode(str));

String clearAllResModelToJson(ClearAllResModel data) => json.encode(data.toJson());

class ClearAllResModel {
    bool success;
    String message;

    ClearAllResModel({
        required this.success,
        required this.message,
    });

    factory ClearAllResModel.fromJson(Map<String, dynamic> json) => ClearAllResModel(
        success: json["success"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
    };
}

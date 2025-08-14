// To parse this JSON data, do
//
//     final deletewishlistResModel = deletewishlistResModelFromJson(jsonString);

import 'dart:convert';

DeletewishlistResModel deletewishlistResModelFromJson(String str) => DeletewishlistResModel.fromJson(json.decode(str));

String deletewishlistResModelToJson(DeletewishlistResModel data) => json.encode(data.toJson());

class DeletewishlistResModel {
    String message;

    DeletewishlistResModel({
        required this.message,
    });

    factory DeletewishlistResModel.fromJson(Map<String, dynamic> json) => DeletewishlistResModel(
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
    };
}

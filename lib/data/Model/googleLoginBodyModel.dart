// To parse this JSON data, do
//
//     final googleLoginBodyModel = googleLoginBodyModelFromJson(jsonString);

import 'dart:convert';

GoogleLoginBodyModel googleLoginBodyModelFromJson(String str) => GoogleLoginBodyModel.fromJson(json.decode(str));

String googleLoginBodyModelToJson(GoogleLoginBodyModel data) => json.encode(data.toJson());

class GoogleLoginBodyModel {
    String username;
    String email;
    String password;
    String confirmPassword;

    GoogleLoginBodyModel({
        required this.username,
        required this.email,
        required this.password,
        required this.confirmPassword,
    });

    factory GoogleLoginBodyModel.fromJson(Map<String, dynamic> json) => GoogleLoginBodyModel(
        username: json["username"],
        email: json["email"],
        password: json["password"],
        confirmPassword: json["confirm_password"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "password": password,
        "confirm_password": confirmPassword,
    };
}

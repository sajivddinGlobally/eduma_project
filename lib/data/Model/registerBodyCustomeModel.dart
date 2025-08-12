// To parse this JSON data, do
//
//     final registerBodyCustomeModel = registerBodyCustomeModelFromJson(jsonString);

import 'dart:convert';

RegisterBodyCustomeModel registerBodyCustomeModelFromJson(String str) => RegisterBodyCustomeModel.fromJson(json.decode(str));

String registerBodyCustomeModelToJson(RegisterBodyCustomeModel data) => json.encode(data.toJson());

class RegisterBodyCustomeModel {
    String username;
    String email;
    String password;
    String confirmPassword;

    RegisterBodyCustomeModel({
        required this.username,
        required this.email,
        required this.password,
        required this.confirmPassword,
    });

    factory RegisterBodyCustomeModel.fromJson(Map<String, dynamic> json) => RegisterBodyCustomeModel(
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

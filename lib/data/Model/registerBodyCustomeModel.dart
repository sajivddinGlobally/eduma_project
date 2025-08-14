// To parse this JSON data, do
//
//     final registerBodyModel = registerBodyModelFromJson(jsonString);

import 'dart:convert';

RegisterBodyModel registerBodyModelFromJson(String str) => RegisterBodyModel.fromJson(json.decode(str));

String registerBodyModelToJson(RegisterBodyModel data) => json.encode(data.toJson());

class RegisterBodyModel {
    String username;
    String email;
    String password;
    String confirmPassword;
    String roleType;

    RegisterBodyModel({
        required this.username,
        required this.email,
        required this.password,
        required this.confirmPassword,
        required this.roleType,
    });

    factory RegisterBodyModel.fromJson(Map<String, dynamic> json) => RegisterBodyModel(
        username: json["username"],
        email: json["email"],
        password: json["password"],
        confirmPassword: json["confirm_password"],
        roleType: json["role_type"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "password": password,
        "confirm_password": confirmPassword,
        "role_type": roleType,
    };
}

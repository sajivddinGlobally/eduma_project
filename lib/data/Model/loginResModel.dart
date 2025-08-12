// To parse this JSON data, do
//
//     final loginResModel = loginResModelFromJson(jsonString);

import 'dart:convert';

LoginResModel loginResModelFromJson(String str) => LoginResModel.fromJson(json.decode(str));

String loginResModelToJson(LoginResModel data) => json.encode(data.toJson());

class LoginResModel {
    String token;
    String userEmail;
    String userNicename;
    String userDisplayName;
    List<String> roles;
    String storeName;
    int storeId;

    LoginResModel({
        required this.token,
        required this.userEmail,
        required this.userNicename,
        required this.userDisplayName,
        required this.roles,
        required this.storeName,
        required this.storeId,
    });

    factory LoginResModel.fromJson(Map<String, dynamic> json) => LoginResModel(
        token: json["token"],
        userEmail: json["user_email"],
        userNicename: json["user_nicename"],
        userDisplayName: json["user_display_name"],
        roles: List<String>.from(json["roles"].map((x) => x)),
        storeName: json["store_name"],
        storeId: json["store_id"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "user_email": userEmail,
        "user_nicename": userNicename,
        "user_display_name": userDisplayName,
        "roles": List<dynamic>.from(roles.map((x) => x)),
        "store_name": storeName,
        "store_id": storeId,
    };
}

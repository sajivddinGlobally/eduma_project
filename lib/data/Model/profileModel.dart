// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
    int id;
    String username;
    String name;
    String email;
    bool avatar;
    String bio;
    String phone;

    ProfileModel({
        required this.id,
        required this.username,
        required this.name,
        required this.email,
        required this.avatar,
        required this.bio,
        required this.phone,
    });

    factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        id: json["id"],
        username: json["username"],
        name: json["name"],
        email: json["email"],
        avatar: json["avatar"],
        bio: json["bio"],
        phone: json["phone"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "name": name,
        "email": email,
        "avatar": avatar,
        "bio": bio,
        "phone": phone,
    };
}

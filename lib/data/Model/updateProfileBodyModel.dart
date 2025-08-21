// To parse this JSON data, do
//
//     final updateProfileBodyModel = updateProfileBodyModelFromJson(jsonString);

import 'dart:convert';

UpdateProfileBodyModel updateProfileBodyModelFromJson(String str) =>
    UpdateProfileBodyModel.fromJson(json.decode(str));

String updateProfileBodyModelToJson(UpdateProfileBodyModel data) =>
    json.encode(data.toJson());

class UpdateProfileBodyModel {
  String firstName;
  String email;
  String phone;
  String bio;
  String city;
  String state;
  String address;
  String avatarUrl;

  UpdateProfileBodyModel({
    required this.firstName,
    required this.email,
    required this.phone,
    required this.bio,
    required this.city,
    required this.state,
    required this.address,
    required this.avatarUrl,
  });

  factory UpdateProfileBodyModel.fromJson(Map<String, dynamic> json) =>
      UpdateProfileBodyModel(
        firstName: json["first_name"],
        email: json["email"],
        phone: json["phone"],
        bio: json["bio"],
        city: json["city"],
        state: json["state"],
        address: json['address'],
        avatarUrl: json["avatar_url"],
      );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "email": email,
    "phone": phone,
    "bio": bio,
    "city": city,
    "state": state,
    "address": address,
    "avatar_url": avatarUrl,
  };
}

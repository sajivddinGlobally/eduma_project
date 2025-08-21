// To parse this JSON data, do
//
//     final updateProfileResModel = updateProfileResModelFromJson(jsonString);

import 'dart:convert';

UpdateProfileResModel updateProfileResModelFromJson(String str) => UpdateProfileResModel.fromJson(json.decode(str));

String updateProfileResModelToJson(UpdateProfileResModel data) => json.encode(data.toJson());

class UpdateProfileResModel {
    bool success;
    String message;
    List<String> updatedFields;
    Profile profile;

    UpdateProfileResModel({
        required this.success,
        required this.message,
        required this.updatedFields,
        required this.profile,
    });

    factory UpdateProfileResModel.fromJson(Map<String, dynamic> json) => UpdateProfileResModel(
        success: json["success"],
        message: json["message"],
        updatedFields: List<String>.from(json["updated_fields"].map((x) => x)),
        profile: Profile.fromJson(json["profile"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "updated_fields": List<dynamic>.from(updatedFields.map((x) => x)),
        "profile": profile.toJson(),
    };
}

class Profile {
    int id;
    String firstName;
    String email;
    String phone;
    String bio;
    String address;
    String city;
    String state;
    String avatarUrl;

    Profile({
        required this.id,
        required this.firstName,
        required this.email,
        required this.phone,
        required this.bio,
        required this.address,
        required this.city,
        required this.state,
        required this.avatarUrl,
    });

    factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["id"],
        firstName: json["first_name"],
        email: json["email"],
        phone: json["phone"],
        bio: json["bio"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
        avatarUrl: json["avatar_url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "email": email,
        "phone": phone,
        "bio": bio,
        "address": address,
        "city": city,
        "state": state,
        "avatar_url": avatarUrl,
    };
}

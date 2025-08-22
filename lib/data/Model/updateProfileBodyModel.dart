// To parse this JSON data, do
//
//     final updateProfileBodyModel = updateProfileBodyModelFromJson(jsonString);

import 'dart:convert';

UpdateProfileBodyModel updateProfileBodyModelFromJson(String str) => UpdateProfileBodyModel.fromJson(json.decode(str));

String updateProfileBodyModelToJson(UpdateProfileBodyModel data) => json.encode(data.toJson());

class UpdateProfileBodyModel {
    String firstName;
    String lastName;
    String displayName;
    String email;
    String phone;
    String bio;
    String address;
    String city;
    String state;
    String country;
    String postalCode;
    String avatarUrl;

    UpdateProfileBodyModel({
        required this.firstName,
        required this.lastName,
        required this.displayName,
        required this.email,
        required this.phone,
        required this.bio,
        required this.address,
        required this.city,
        required this.state,
        required this.country,
        required this.postalCode,
        required this.avatarUrl,
    });

    factory UpdateProfileBodyModel.fromJson(Map<String, dynamic> json) => UpdateProfileBodyModel(
        firstName: json["first_name"],
        lastName: json["last_name"],
        displayName: json["display_name"],
        email: json["email"],
        phone: json["phone"],
        bio: json["bio"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        postalCode: json["postal_code"],
        avatarUrl: json["avatar_url"],
    );

    Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "display_name": displayName,
        "email": email,
        "phone": phone,
        "bio": bio,
        "address": address,
        "city": city,
        "state": state,
        "country": country,
        "postal_code": postalCode,
        "avatar_url": avatarUrl,
    };
}

// // To parse this JSON data, do
// //
// //     final updateProfileBodyModel = updateProfileBodyModelFromJson(jsonString);

// import 'dart:convert';

// UpdateProfileBodyModel updateProfileBodyModelFromJson(String str) => UpdateProfileBodyModel.fromJson(json.decode(str));

// String updateProfileBodyModelToJson(UpdateProfileBodyModel data) => json.encode(data.toJson());

// class UpdateProfileBodyModel {
//     String firstName;
//     String lastName;
//     String displayName;
//     String email;
//     String phone;
//     String bio;
//     String address;
//     String city;
//     String state;
//     String country;
//     String postalCode;
//     String avatarUrl;

//     UpdateProfileBodyModel({
//         required this.firstName,
//         required this.lastName,
//         required this.displayName,
//         required this.email,
//         required this.phone,
//         required this.bio,
//         required this.address,
//         required this.city,
//         required this.state,
//         required this.country,
//         required this.postalCode,
//         required this.avatarUrl,
//     });

//     factory UpdateProfileBodyModel.fromJson(Map<String, dynamic> json) => UpdateProfileBodyModel(
//         firstName: json["first_name"],
//         lastName: json["last_name"],
//         displayName: json["display_name"],
//         email: json["email"],
//         phone: json["phone"],
//         bio: json["bio"],
//         address: json["address"],
//         city: json["city"],
//         state: json["state"],
//         country: json["country"],
//         postalCode: json["postal_code"],
//         avatarUrl: json["avatar_url"],
//     );

//     Map<String, dynamic> toJson() => {
//         "first_name": firstName,
//         "last_name": lastName,
//         "display_name": displayName,
//         "email": email,
//         "phone": phone,
//         "bio": bio,
//         "address": address,
//         "city": city,
//         "state": state,
//         "country": country,
//         "postal_code": postalCode,
//         "avatar_url": avatarUrl,
//     };
// }

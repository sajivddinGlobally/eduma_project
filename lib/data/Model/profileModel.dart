// // To parse this JSON data, do
// //
// //     final profileModel = profileModelFromJson(jsonString);

// import 'dart:convert';

// ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

// String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

// class ProfileModel {
//     int id;
//     String username;
//     String name;
//     String email;
//     String avatar;
//     String bio;
//     String phone;

//     ProfileModel({
//         required this.id,
//         required this.username,
//         required this.name,
//         required this.email,
//         required this.avatar,
//         required this.bio,
//         required this.phone,
//     });

//     factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
//         id: json["id"],
//         username: json["username"],
//         name: json["name"],
//         email: json["email"],
//         avatar: json["avatar"],
//         bio: json["bio"],
//         phone: json["phone"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "username": username,
//         "name": name,
//         "email": email,
//         "avatar": avatar,
//         "bio": bio,
//         "phone": phone,
//     };
// }

// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  int id;
  String? username;
  String? name;
  String? email;
  String? avatar;
  String? bio;
  String? phone;

  ProfileModel({
    required this.id,
    this.username,
    this.name,
    this.email,
    this.avatar,
    this.bio,
    this.phone,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        id: json["id"] is int
            ? json["id"]
            : int.tryParse(json["id"].toString()) ?? 0,

        // har field ko safe cast kar rahe hain
        username: json["username"]?.toString(),
        name: json["name"]?.toString(),
        email: json["email"]?.toString(),
        avatar: json["avatar"]?.toString(),
        bio: json["bio"]?.toString(),
        phone: json["phone"]?.toString(),
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

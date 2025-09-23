// // To parse this JSON data, do
// //
// //     final googleLoginResModel = googleLoginResModelFromJson(jsonString);

// import 'dart:convert';

// GoogleLoginResModel googleLoginResModelFromJson(String str) => GoogleLoginResModel.fromJson(json.decode(str));

// String googleLoginResModelToJson(GoogleLoginResModel data) => json.encode(data.toJson());

// class GoogleLoginResModel {
//     String token;
//     String userEmail;
//     String userNicename;
//     String userDisplayName;
//     List<String> roles;
//     String storeName;
//     int storeId;

//     GoogleLoginResModel({
//         required this.token,
//         required this.userEmail,
//         required this.userNicename,
//         required this.userDisplayName,
//         required this.roles,
//         required this.storeName,
//         required this.storeId,
//     });

//     factory GoogleLoginResModel.fromJson(Map<String, dynamic> json) => GoogleLoginResModel(
//         token: json["token"],
//         userEmail: json["user_email"],
//         userNicename: json["user_nicename"],
//         userDisplayName: json["user_display_name"],
//         roles: List<String>.from(json["roles"].map((x) => x)),
//         storeName: json["store_name"],
//         storeId: json["store_id"],
//     );

//     Map<String, dynamic> toJson() => {
//         "token": token,
//         "user_email": userEmail,
//         "user_nicename": userNicename,
//         "user_display_name": userDisplayName,
//         "roles": List<dynamic>.from(roles.map((x) => x)),
//         "store_name": storeName,
//         "store_id": storeId,
//     };
// }

// To parse this JSON data, do
//
//     final googleLoginResModel = googleLoginResModelFromJson(jsonString);

import 'dart:convert';

GoogleLoginResModel googleLoginResModelFromJson(String str) =>
    GoogleLoginResModel.fromJson(json.decode(str));

String googleLoginResModelToJson(GoogleLoginResModel data) =>
    json.encode(data.toJson());

class GoogleLoginResModel {
  String token;
  int userId;
  String email;
  String name;
  List<String> roles;

  GoogleLoginResModel({
    required this.token,
    required this.userId,
    required this.email,
    required this.name,
    required this.roles,
  });

  factory GoogleLoginResModel.fromJson(Map<String, dynamic> json) =>
      GoogleLoginResModel(
        token: json["token"],
        userId: json["user_id"],
        email: json["email"],
        name: json["name"],
        roles: List<String>.from(json["roles"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
    "token": token,
    "user_id": userId,
    "email": email,
    "name": name,
    "roles": List<dynamic>.from(roles.map((x) => x)),
  };
}

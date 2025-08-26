// // To parse this JSON data, do
// //
// //     final profileModel = profileModelFromJson(jsonString);

// import 'dart:convert';

// ProfileModel profileModelFromJson(String str) =>
//     ProfileModel.fromJson(json.decode(str));

// String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

// class ProfileModel {
//   int id;
//   String? username;
//   String? name;
//   String? email;
//   String? avatar;
//   String? bio;
//   String? phone;

//   ProfileModel({
//     required this.id,
//     this.username,
//     this.name,
//     this.email,
//     this.avatar,
//     this.bio,
//     this.phone,
//   });

//   factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
//     id: json["id"] is int
//         ? json["id"]
//         : int.tryParse(json["id"].toString()) ?? 0,

//     // har field ko safe cast kar rahe hain
//     username: json["username"]?.toString(),
//     name: json["name"]?.toString(),
//     email: json["email"]?.toString(),
//     avatar: json["avatar"]?.toString(),
//     bio: json["bio"]?.toString(),
//     phone: json["phone"]?.toString(),
//   );

//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "username": username,
//     "name": name,
//     "email": email,
//     "avatar": avatar,
//     "bio": bio,
//     "phone": phone,
//   };
// }

// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
    int id;
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
    int enrolledCourses;
    int completedCourses;
    int certificatesEarned;
    DateTime registrationDate;

    ProfileModel({
        required this.id,
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
        required this.enrolledCourses,
        required this.completedCourses,
        required this.certificatesEarned,
        required this.registrationDate,
    });

    factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        id: json["id"],
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
        enrolledCourses: json["enrolled_courses"],
        completedCourses: json["completed_courses"],
        certificatesEarned: json["certificates_earned"],
        registrationDate: DateTime.parse(json["registration_date"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
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
        "enrolled_courses": enrolledCourses,
        "completed_courses": completedCourses,
        "certificates_earned": certificatesEarned,
        "registration_date": registrationDate.toIso8601String(),
    };
}

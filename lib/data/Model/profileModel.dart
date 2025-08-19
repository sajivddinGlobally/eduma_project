// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
    String status;
    Data data;

    ProfileModel({
        required this.status,
        required this.data,
    });

    factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
    };
}

class Data {
    int userId;
    String username;
    String email;
    String displayName;
    String firstName;
    String lastName;
    String phone;
    String dateOfBirth;
    String gender;
    String bio;
    String website;
    String avatarUrl;
    Address address;
    SocialLinks socialLinks;
    AccountInfo accountInfo;
    CourseStats courseStats;

    Data({
        required this.userId,
        required this.username,
        required this.email,
        required this.displayName,
        required this.firstName,
        required this.lastName,
        required this.phone,
        required this.dateOfBirth,
        required this.gender,
        required this.bio,
        required this.website,
        required this.avatarUrl,
        required this.address,
        required this.socialLinks,
        required this.accountInfo,
        required this.courseStats,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["user_id"],
        username: json["username"],
        email: json["email"],
        displayName: json["display_name"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phone: json["phone"],
        dateOfBirth: json["date_of_birth"],
        gender: json["gender"],
        bio: json["bio"],
        website: json["website"],
        avatarUrl: json["avatar_url"],
        address: Address.fromJson(json["address"]),
        socialLinks: SocialLinks.fromJson(json["social_links"]),
        accountInfo: AccountInfo.fromJson(json["account_info"]),
        courseStats: CourseStats.fromJson(json["course_stats"]),
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "username": username,
        "email": email,
        "display_name": displayName,
        "first_name": firstName,
        "last_name": lastName,
        "phone": phone,
        "date_of_birth": dateOfBirth,
        "gender": gender,
        "bio": bio,
        "website": website,
        "avatar_url": avatarUrl,
        "address": address.toJson(),
        "social_links": socialLinks.toJson(),
        "account_info": accountInfo.toJson(),
        "course_stats": courseStats.toJson(),
    };
}

class AccountInfo {
    DateTime registrationDate;
    String lastLogin;
    String role;

    AccountInfo({
        required this.registrationDate,
        required this.lastLogin,
        required this.role,
    });

    factory AccountInfo.fromJson(Map<String, dynamic> json) => AccountInfo(
        registrationDate: DateTime.parse(json["registration_date"]),
        lastLogin: json["last_login"],
        role: json["role"],
    );

    Map<String, dynamic> toJson() => {
        "registration_date": registrationDate.toIso8601String(),
        "last_login": lastLogin,
        "role": role,
    };
}

class Address {
    String street;
    String city;
    String state;
    String country;
    String postalCode;

    Address({
        required this.street,
        required this.city,
        required this.state,
        required this.country,
        required this.postalCode,
    });

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        street: json["street"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        postalCode: json["postal_code"],
    );

    Map<String, dynamic> toJson() => {
        "street": street,
        "city": city,
        "state": state,
        "country": country,
        "postal_code": postalCode,
    };
}

class CourseStats {
    int totalEnrolled;
    int totalCompleted;
    int totalActive;
    int completionRate;

    CourseStats({
        required this.totalEnrolled,
        required this.totalCompleted,
        required this.totalActive,
        required this.completionRate,
    });

    factory CourseStats.fromJson(Map<String, dynamic> json) => CourseStats(
        totalEnrolled: json["total_enrolled"],
        totalCompleted: json["total_completed"],
        totalActive: json["total_active"],
        completionRate: json["completion_rate"],
    );

    Map<String, dynamic> toJson() => {
        "total_enrolled": totalEnrolled,
        "total_completed": totalCompleted,
        "total_active": totalActive,
        "completion_rate": completionRate,
    };
}

class SocialLinks {
    String facebook;
    String twitter;
    String linkedin;
    String instagram;
    String github;

    SocialLinks({
        required this.facebook,
        required this.twitter,
        required this.linkedin,
        required this.instagram,
        required this.github,
    });

    factory SocialLinks.fromJson(Map<String, dynamic> json) => SocialLinks(
        facebook: json["facebook"],
        twitter: json["twitter"],
        linkedin: json["linkedin"],
        instagram: json["instagram"],
        github: json["github"],
    );

    Map<String, dynamic> toJson() => {
        "facebook": facebook,
        "twitter": twitter,
        "linkedin": linkedin,
        "instagram": instagram,
        "github": github,
    };
}

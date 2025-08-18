// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
    String code;
    String message;
    Data data;

    ProfileModel({
        required this.code,
        required this.message,
        required this.data,
    });

    factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        code: json["code"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    String firstName;
    String lastName;
    String displayName;
    String userEmail;
    String userName;
    String jobTitle;
    String bio;
    String phoneNumber;
    String profilePhotoUrl;
    String coverPhotoUrl;
    SocialLinks socialLinks;

    Data({
        required this.firstName,
        required this.lastName,
        required this.displayName,
        required this.userEmail,
        required this.userName,
        required this.jobTitle,
        required this.bio,
        required this.phoneNumber,
        required this.profilePhotoUrl,
        required this.coverPhotoUrl,
        required this.socialLinks,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        firstName: json["first_name"],
        lastName: json["last_name"],
        displayName: json["display_name"],
        userEmail: json["user_email"],
        userName: json["user_name"],
        jobTitle: json["job_title"],
        bio: json["bio"],
        phoneNumber: json["phone_number"],
        profilePhotoUrl: json["profile_photo_url"],
        coverPhotoUrl: json["cover_photo_url"],
        socialLinks: SocialLinks.fromJson(json["social_links"]),
    );

    Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "display_name": displayName,
        "user_email": userEmail,
        "user_name": userName,
        "job_title": jobTitle,
        "bio": bio,
        "phone_number": phoneNumber,
        "profile_photo_url": profilePhotoUrl,
        "cover_photo_url": coverPhotoUrl,
        "social_links": socialLinks.toJson(),
    };
}

class SocialLinks {
    String facebook;
    String twitter;
    String linkedin;
    String website;
    String github;

    SocialLinks({
        required this.facebook,
        required this.twitter,
        required this.linkedin,
        required this.website,
        required this.github,
    });

    factory SocialLinks.fromJson(Map<String, dynamic> json) => SocialLinks(
        facebook: json["facebook"],
        twitter: json["twitter"],
        linkedin: json["linkedin"],
        website: json["website"],
        github: json["github"],
    );

    Map<String, dynamic> toJson() => {
        "facebook": facebook,
        "twitter": twitter,
        "linkedin": linkedin,
        "website": website,
        "github": github,
    };
}

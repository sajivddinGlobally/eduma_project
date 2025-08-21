// To parse this JSON data, do
//
//     final enrollBodyResModel = enrollBodyResModelFromJson(jsonString);

import 'dart:convert';

EnrollBodyResModel enrollBodyResModelFromJson(String str) => EnrollBodyResModel.fromJson(json.decode(str));

String enrollBodyResModelToJson(EnrollBodyResModel data) => json.encode(data.toJson());

class EnrollBodyResModel {
    bool success;
    String message;
    bool alreadyEnrolled;
    Course course;

    EnrollBodyResModel({
        required this.success,
        required this.message,
        required this.alreadyEnrolled,
        required this.course,
    });

    factory EnrollBodyResModel.fromJson(Map<String, dynamic> json) => EnrollBodyResModel(
        success: json["success"],
        message: json["message"],
        alreadyEnrolled: json["already_enrolled"],
        course: Course.fromJson(json["course"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "already_enrolled": alreadyEnrolled,
        "course": course.toJson(),
    };
}

class Course {
    int id;
    String title;
    String url;

    Course({
        required this.id,
        required this.title,
        required this.url,
    });

    factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json["id"],
        title: json["title"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "url": url,
    };
}

// To parse this JSON data, do
//
//     final enrollResModel = enrollResModelFromJson(jsonString);

import 'dart:convert';

EnrollResModel enrollResModelFromJson(String str) =>
    EnrollResModel.fromJson(json.decode(str));

String enrollResModelToJson(EnrollResModel data) => json.encode(data.toJson());

class EnrollResModel {
  bool success;
  String message;
  int enrollmentId;
  Course course;
  DateTime enrollmentDate;

  EnrollResModel({
    required this.success,
    required this.message,
    required this.enrollmentId,
    required this.course,
    required this.enrollmentDate,
  });

  factory EnrollResModel.fromJson(Map<String, dynamic> json) => EnrollResModel(
    success: json["success"],
    message: json["message"],
    enrollmentId: json["enrollment_id"],
    course: Course.fromJson(json["course"]),
    enrollmentDate: DateTime.parse(json["enrollment_date"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "enrollment_id": enrollmentId,
    "course": course.toJson(),
    "enrollment_date": enrollmentDate.toIso8601String(),
  };
}

class Course {
  int id;
  String title;
  String url;

  Course({required this.id, required this.title, required this.url});

  factory Course.fromJson(Map<String, dynamic> json) =>
      Course(id: json["id"], title: json["title"], url: json["url"]);

  Map<String, dynamic> toJson() => {"id": id, "title": title, "url": url};
}

// To parse this JSON data, do
//
//     final enrolleCourseStudentModel = enrolleCourseStudentModelFromJson(jsonString);

import 'dart:convert';

EnrolleCourseStudentModel enrolleCourseStudentModelFromJson(String str) => EnrolleCourseStudentModel.fromJson(json.decode(str));

String enrolleCourseStudentModelToJson(EnrolleCourseStudentModel data) => json.encode(data.toJson());

class EnrolleCourseStudentModel {
    int total;
    int page;
    int perPage;
    List<Course> courses;

    EnrolleCourseStudentModel({
        required this.total,
        required this.page,
        required this.perPage,
        required this.courses,
    });

    factory EnrolleCourseStudentModel.fromJson(Map<String, dynamic> json) => EnrolleCourseStudentModel(
        total: json["total"],
        page: json["page"],
        perPage: json["per_page"],
        courses: List<Course>.from(json["courses"].map((x) => Course.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "page": page,
        "per_page": perPage,
        "courses": List<dynamic>.from(courses.map((x) => x.toJson())),
    };
}

class Course {
    int id;
    String title;
    String permalink;
    String thumbnail;
    String status;
    int progress;

    Course({
        required this.id,
        required this.title,
        required this.permalink,
        required this.thumbnail,
        required this.status,
        required this.progress,
    });

    factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json["id"],
        title: json["title"],
        permalink: json["permalink"],
        thumbnail: json["thumbnail"],
        status: json["status"],
        progress: json["progress"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "permalink": permalink,
        "thumbnail": thumbnail,
        "status": status,
        "progress": progress,
    };
}

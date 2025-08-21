// To parse this JSON data, do
//
//     final enrollBodyModel = enrollBodyModelFromJson(jsonString);

import 'dart:convert';

EnrollBodyModel enrollBodyModelFromJson(String str) => EnrollBodyModel.fromJson(json.decode(str));

String enrollBodyModelToJson(EnrollBodyModel data) => json.encode(data.toJson());

class EnrollBodyModel {
    int courseId;

    EnrollBodyModel({
        required this.courseId,
    });

    factory EnrollBodyModel.fromJson(Map<String, dynamic> json) => EnrollBodyModel(
        courseId: json["course_id"],
    );

    Map<String, dynamic> toJson() => {
        "course_id": courseId,
    };
}

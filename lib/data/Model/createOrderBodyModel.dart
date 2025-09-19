// To parse this JSON data, do
//
//     final createOrderCourseBodyModel = createOrderCourseBodyModelFromJson(jsonString);

import 'dart:convert';

CreateOrderCourseBodyModel createOrderCourseBodyModelFromJson(String str) => CreateOrderCourseBodyModel.fromJson(json.decode(str));

String createOrderCourseBodyModelToJson(CreateOrderCourseBodyModel data) => json.encode(data.toJson());

class CreateOrderCourseBodyModel {
    String courseId;
    String price;

    CreateOrderCourseBodyModel({
        required this.courseId,
        required this.price,
    });

    factory CreateOrderCourseBodyModel.fromJson(Map<String, dynamic> json) => CreateOrderCourseBodyModel(
        courseId: json["course_id"],
        price: json["price"],
    );

    Map<String, dynamic> toJson() => {
        "course_id": courseId,
        "price": price,
    };
}

// To parse this JSON data, do
//
//     final instructorModel = instructorModelFromJson(jsonString);

import 'dart:convert';

List<InstructorModel> instructorModelFromJson(String str) => List<InstructorModel>.from(json.decode(str).map((x) => InstructorModel.fromJson(x)));

String instructorModelToJson(List<InstructorModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InstructorModel {
    int id;
    String name;
    String email;
    String phone;
    String bio;
    String avatarUrl;
    int totalCourses;
    int totalEnrollments;
    List<Course> courses;

    InstructorModel({
        required this.id,
        required this.name,
        required this.email,
        required this.phone,
        required this.bio,
        required this.avatarUrl,
        required this.totalCourses,
        required this.totalEnrollments,
        required this.courses,
    });

    factory InstructorModel.fromJson(Map<String, dynamic> json) => InstructorModel(
        id: json["ID"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        bio: json["bio"],
        avatarUrl: json["avatar_url"],
        totalCourses: json["total_courses"],
        totalEnrollments: json["total_enrollments"],
        courses: List<Course>.from(json["courses"].map((x) => Course.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ID": id,
        "name": name,
        "email": email,
        "phone": phone,
        "bio": bio,
        "avatar_url": avatarUrl,
        "total_courses": totalCourses,
        "total_enrollments": totalEnrollments,
        "courses": List<dynamic>.from(courses.map((x) => x.toJson())),
    };
}

class Course {
    int id;
    String title;
    String excerpt;
    String thumbnail;
    String permalink;
    Price price;
    PriceLabel priceLabel;
    bool isFree;
    dynamic enrollCount;
    Rating rating;
    Duration duration;

    Course({
        required this.id,
        required this.title,
        required this.excerpt,
        required this.thumbnail,
        required this.permalink,
        required this.price,
        required this.priceLabel,
        required this.isFree,
        required this.enrollCount,
        required this.rating,
        required this.duration,
    });

    factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json["id"],
        title: json["title"],
        excerpt: json["excerpt"],
        thumbnail: json["thumbnail"],
        permalink: json["permalink"],
        price: Price.fromJson(json["price"]),
        priceLabel: priceLabelValues.map[json["price_label"]]!,
        isFree: json["is_free"],
        enrollCount: json["enroll_count"],
        rating: Rating.fromJson(json["rating"]),
        duration: durationValues.map[json["duration"]]!,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "excerpt": excerpt,
        "thumbnail": thumbnail,
        "permalink": permalink,
        "price": price.toJson(),
        "price_label": priceLabelValues.reverse[priceLabel],
        "is_free": isFree,
        "enroll_count": enrollCount,
        "rating": rating.toJson(),
        "duration": durationValues.reverse[duration],
    };
}

enum Duration {
    EMPTY,
    THE_7_H
}

final durationValues = EnumValues({
    "": Duration.EMPTY,
    "7h ": Duration.THE_7_H
});

class Price {
    int regularPrice;
    int salePrice;
    int displayPrice;

    Price({
        required this.regularPrice,
        required this.salePrice,
        required this.displayPrice,
    });

    factory Price.fromJson(Map<String, dynamic> json) => Price(
        regularPrice: json["regular_price"],
        salePrice: json["sale_price"],
        displayPrice: json["display_price"],
    );

    Map<String, dynamic> toJson() => {
        "regular_price": regularPrice,
        "sale_price": salePrice,
        "display_price": displayPrice,
    };
}

enum PriceLabel {
    FREE
}

final priceLabelValues = EnumValues({
    "Free": PriceLabel.FREE
});

class Rating {
    dynamic ratingCount;
    dynamic ratingSum;
    dynamic ratingAvg;
    Map<String, dynamic> countByValue;

    Rating({
        required this.ratingCount,
        required this.ratingSum,
        required this.ratingAvg,
        required this.countByValue,
    });

    factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        ratingCount: json["rating_count"],
        ratingSum: json["rating_sum"],
        ratingAvg: json["rating_avg"],
        countByValue: Map.from(json["count_by_value"]).map((k, v) => MapEntry<String, dynamic>(k, v)),
    );

    Map<String, dynamic> toJson() => {
        "rating_count": ratingCount,
        "rating_sum": ratingSum,
        "rating_avg": ratingAvg,
        "count_by_value": Map.from(countByValue).map((k, v) => MapEntry<String, dynamic>(k, v)),
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}

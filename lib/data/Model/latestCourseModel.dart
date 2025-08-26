// To parse this JSON data, do
//
//     final latestCourseModel = latestCourseModelFromJson(jsonString);

import 'dart:convert';

LatestCourseModel latestCourseModelFromJson(String str) => LatestCourseModel.fromJson(json.decode(str));

String latestCourseModelToJson(LatestCourseModel data) => json.encode(data.toJson());

class LatestCourseModel {
    bool success;
    int totalCourses;
    List<Course> courses;

    LatestCourseModel({
        required this.success,
        required this.totalCourses,
        required this.courses,
    });

    factory LatestCourseModel.fromJson(Map<String, dynamic> json) => LatestCourseModel(
        success: json["success"],
        totalCourses: json["total_courses"],
        courses: List<Course>.from(json["courses"].map((x) => Course.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "total_courses": totalCourses,
        "courses": List<dynamic>.from(courses.map((x) => x.toJson())),
    };
}

class Course {
    int id;
    String title;
    String description;
    String permalink;
    String featuredImage;
    DateTime dateCreated;
    Price price;
    Level level;
    Instructor instructor;
    Stats stats;
    List<String> categories;
    DebugMeta debugMeta;

    Course({
        required this.id,
        required this.title,
        required this.description,
        required this.permalink,
        required this.featuredImage,
        required this.dateCreated,
        required this.price,
        required this.level,
        required this.instructor,
        required this.stats,
        required this.categories,
        required this.debugMeta,
    });

    factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        permalink: json["permalink"],
        featuredImage: json["featured_image"],
        dateCreated: DateTime.parse(json["date_created"]),
        price: Price.fromJson(json["price"]),
        level: levelValues.map[json["level"]]!,
        instructor: Instructor.fromJson(json["instructor"]),
        stats: Stats.fromJson(json["stats"]),
        categories: List<String>.from(json["categories"].map((x) => x)),
        debugMeta: DebugMeta.fromJson(json["debug_meta"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "permalink": permalink,
        "featured_image": featuredImage,
        "date_created": dateCreated.toIso8601String(),
        "price": price.toJson(),
        "level": levelValues.reverse[level],
        "instructor": instructor.toJson(),
        "stats": stats.toJson(),
        "categories": List<dynamic>.from(categories.map((x) => x)),
        "debug_meta": debugMeta.toJson(),
    };
}

class DebugMeta {
    String tutorCoursePrice;
    String debugMetaTutorCoursePrice;
    String price;
    String productId;

    DebugMeta({
        required this.tutorCoursePrice,
        required this.debugMetaTutorCoursePrice,
        required this.price,
        required this.productId,
    });

    factory DebugMeta.fromJson(Map<String, dynamic> json) => DebugMeta(
        tutorCoursePrice: json["_tutor_course_price"],
        debugMetaTutorCoursePrice: json["tutor_course_price"],
        price: json["_price"],
        productId: json["product_id"],
    );

    Map<String, dynamic> toJson() => {
        "_tutor_course_price": tutorCoursePrice,
        "tutor_course_price": debugMetaTutorCoursePrice,
        "_price": price,
        "product_id": productId,
    };
}

class Instructor {
    String id;
    Name name;
    String avatar;

    Instructor({
        required this.id,
        required this.name,
        required this.avatar,
    });

    factory Instructor.fromJson(Map<String, dynamic> json) => Instructor(
        id: json["id"],
        name: nameValues.map[json["name"]]!,
        avatar: json["avatar"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": nameValues.reverse[name],
        "avatar": avatar,
    };
}

enum Name {
    ANIL_KUMAR_SINGH
}

final nameValues = EnumValues({
    "Anil Kumar Singh": Name.ANIL_KUMAR_SINGH
});

enum Level {
    ALL_LEVELS,
    BEGINNER,
    INTERMEDIATE
}

final levelValues = EnumValues({
    "all_levels": Level.ALL_LEVELS,
    "beginner": Level.BEGINNER,
    "intermediate": Level.INTERMEDIATE
});

class Price {
    int regularPrice;
    int salePrice;
    PriceType priceType;
    bool isFree;
    Currency currency;
    CurrencySymbol currencySymbol;

    Price({
        required this.regularPrice,
        required this.salePrice,
        required this.priceType,
        required this.isFree,
        required this.currency,
        required this.currencySymbol,
    });

    factory Price.fromJson(Map<String, dynamic> json) => Price(
        regularPrice: json["regular_price"],
        salePrice: json["sale_price"],
        priceType: priceTypeValues.map[json["price_type"]]!,
        isFree: json["is_free"],
        currency: currencyValues.map[json["currency"]]!,
        currencySymbol: currencySymbolValues.map[json["currency_symbol"]]!,
    );

    Map<String, dynamic> toJson() => {
        "regular_price": regularPrice,
        "sale_price": salePrice,
        "price_type": priceTypeValues.reverse[priceType],
        "is_free": isFree,
        "currency": currencyValues.reverse[currency],
        "currency_symbol": currencySymbolValues.reverse[currencySymbol],
    };
}

enum Currency {
    USD
}

final currencyValues = EnumValues({
    "USD": Currency.USD
});

enum CurrencySymbol {
    THE_36
}

final currencySymbolValues = EnumValues({
    "&#36;": CurrencySymbol.THE_36
});

enum PriceType {
    FREE,
    PAID
}

final priceTypeValues = EnumValues({
    "free": PriceType.FREE,
    "paid": PriceType.PAID
});

class Stats {
    int totalStudents;
    int totalLessons;
    int averageRating;
    int ratingCount;

    Stats({
        required this.totalStudents,
        required this.totalLessons,
        required this.averageRating,
        required this.ratingCount,
    });

    factory Stats.fromJson(Map<String, dynamic> json) => Stats(
        totalStudents: json["total_students"],
        totalLessons: json["total_lessons"],
        averageRating: json["average_rating"],
        ratingCount: json["rating_count"],
    );

    Map<String, dynamic> toJson() => {
        "total_students": totalStudents,
        "total_lessons": totalLessons,
        "average_rating": averageRating,
        "rating_count": ratingCount,
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

// To parse this JSON data, do
//
//     final popularCourseDetailsModel = popularCourseDetailsModelFromJson(jsonString);

import 'dart:convert';

List<PopularCourseDetailsModel> popularCourseDetailsModelFromJson(String str) => List<PopularCourseDetailsModel>.from(json.decode(str).map((x) => PopularCourseDetailsModel.fromJson(x)));

String popularCourseDetailsModelToJson(List<PopularCourseDetailsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PopularCourseDetailsModel {
    int id;
    String title;
    String excerpt;
    String description;
    String thumbnail;
    String permalink;
    Price price;
    PriceRaw priceRaw;
    Duration duration;
    Difficulty difficulty;
    List<Category> categories;
    dynamic enrollCount;
    Rating rating;
    Author author;

    PopularCourseDetailsModel({
        required this.id,
        required this.title,
        required this.excerpt,
        required this.description,
        required this.thumbnail,
        required this.permalink,
        required this.price,
        required this.priceRaw,
        required this.duration,
        required this.difficulty,
        required this.categories,
        required this.enrollCount,
        required this.rating,
        required this.author,
    });

    factory PopularCourseDetailsModel.fromJson(Map<String, dynamic> json) => PopularCourseDetailsModel(
        id: json["id"],
        title: json["title"],
        excerpt: json["excerpt"],
        description: json["description"],
        thumbnail: json["thumbnail"],
        permalink: json["permalink"],
        price: priceValues.map[json["price"]]!,
        priceRaw: PriceRaw.fromJson(json["price_raw"]),
        duration: Duration.fromJson(json["duration"]),
        difficulty: difficultyValues.map[json["difficulty"]]!,
        categories: List<Category>.from(json["categories"].map((x) => categoryValues.map[x]!)),
        enrollCount: json["enroll_count"],
        rating: Rating.fromJson(json["rating"]),
        author: Author.fromJson(json["author"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "excerpt": excerpt,
        "description": description,
        "thumbnail": thumbnail,
        "permalink": permalink,
        "price": priceValues.reverse[price],
        "price_raw": priceRaw.toJson(),
        "duration": duration.toJson(),
        "difficulty": difficultyValues.reverse[difficulty],
        "categories": List<dynamic>.from(categories.map((x) => categoryValues.reverse[x])),
        "enroll_count": enrollCount,
        "rating": rating.toJson(),
        "author": author.toJson(),
    };
}

class Author {
    int id;
    Name name;
    Email email;
    String avatarUrl;

    Author({
        required this.id,
        required this.name,
        required this.email,
        required this.avatarUrl,
    });

    factory Author.fromJson(Map<String, dynamic> json) => Author(
        id: json["id"],
        name: nameValues.map[json["name"]]!,
        email: emailValues.map[json["email"]]!,
        avatarUrl: json["avatar_url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": nameValues.reverse[name],
        "email": emailValues.reverse[email],
        "avatar_url": avatarUrl,
    };
}

enum Email {
    NAYNIL1033_GMAIL_COM
}

final emailValues = EnumValues({
    "naynil1033@gmail.com": Email.NAYNIL1033_GMAIL_COM
});

enum Name {
    ANIL_KUMAR_SINGH
}

final nameValues = EnumValues({
    "Anil Kumar Singh": Name.ANIL_KUMAR_SINGH
});

enum Category {
    INTERACTION_PRACTICAL_AMP_QUERY_SESSION,
    WORKSHOP_BASED_ON_DIAGNOSIS_AND_TREATMENT
}

final categoryValues = EnumValues({
    "Interaction Practical &amp; Query Session": Category.INTERACTION_PRACTICAL_AMP_QUERY_SESSION,
    "Workshop based on Diagnosis and Treatment": Category.WORKSHOP_BASED_ON_DIAGNOSIS_AND_TREATMENT
});

enum Difficulty {
    ALL_LEVELS,
    BEGINNER,
    INTERMEDIATE
}

final difficultyValues = EnumValues({
    "All_levels": Difficulty.ALL_LEVELS,
    "Beginner": Difficulty.BEGINNER,
    "Intermediate": Difficulty.INTERMEDIATE
});

class Duration {
    String hours;
    String minutes;

    Duration({
        required this.hours,
        required this.minutes,
    });

    factory Duration.fromJson(Map<String, dynamic> json) => Duration(
        hours: json["hours"],
        minutes: json["minutes"],
    );

    Map<String, dynamic> toJson() => {
        "hours": hours,
        "minutes": minutes,
    };
}

enum Price {
    PAID
}

final priceValues = EnumValues({
    "paid": Price.PAID
});

class PriceRaw {
    int regularPrice;
    int salePrice;
    int displayPrice;
    int taxRate;
    int taxAmount;
    bool showInclTaxLabel;

    PriceRaw({
        required this.regularPrice,
        required this.salePrice,
        required this.displayPrice,
        required this.taxRate,
        required this.taxAmount,
        required this.showInclTaxLabel,
    });

    factory PriceRaw.fromJson(Map<String, dynamic> json) => PriceRaw(
        regularPrice: json["regular_price"],
        salePrice: json["sale_price"],
        displayPrice: json["display_price"],
        taxRate: json["tax_rate"],
        taxAmount: json["tax_amount"],
        showInclTaxLabel: json["show_incl_tax_label"],
    );

    Map<String, dynamic> toJson() => {
        "regular_price": regularPrice,
        "sale_price": salePrice,
        "display_price": displayPrice,
        "tax_rate": taxRate,
        "tax_amount": taxAmount,
        "show_incl_tax_label": showInclTaxLabel,
    };
}

class Rating {
    int ratingCount;
    int ratingSum;
    int ratingAvg;
    Map<String, int> countByValue;

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
        countByValue: Map.from(json["count_by_value"]).map((k, v) => MapEntry<String, int>(k, v)),
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

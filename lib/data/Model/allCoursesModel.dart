// To parse this JSON data, do
//
//     final allCoursesModel = allCoursesModelFromJson(jsonString);

import 'dart:convert';

AllCoursesModel allCoursesModelFromJson(String str) =>
    AllCoursesModel.fromJson(json.decode(str));

String allCoursesModelToJson(AllCoursesModel data) =>
    json.encode(data.toJson());

class AllCoursesModel {
  bool success;
  List<Datum> data;
  Pagination pagination;
  Filters filters;
  Summary summary;

  AllCoursesModel({
    required this.success,
    required this.data,
    required this.pagination,
    required this.filters,
    required this.summary,
  });

  factory AllCoursesModel.fromJson(Map<String, dynamic> json) =>
      AllCoursesModel(
        success: json["success"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
        filters: Filters.fromJson(json["filters"]),
        summary: Summary.fromJson(json["summary"]),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "pagination": pagination.toJson(),
    "filters": filters.toJson(),
    "summary": summary.toJson(),
  };
}

class Datum {
  int id;
  String title;
  String excerpt;
  String description;
  String shortDescription;
  Thumbnail thumbnail;
  String permalink;
  Pricing pricing;
  Enrollment enrollment;
  Rating rating;
  CourseInfo courseInfo;
  Author author;
  List<Category> categories;
  List<dynamic> tags;
  List<dynamic> features;
  dynamic requirements;
  List<dynamic> outcomes;
  Meta meta;
  Dates dates;
  Status status;

  Datum({
    required this.id,
    required this.title,
    required this.excerpt,
    required this.description,
    required this.shortDescription,
    required this.thumbnail,
    required this.permalink,
    required this.pricing,
    required this.enrollment,
    required this.rating,
    required this.courseInfo,
    required this.author,
    required this.categories,
    required this.tags,
    required this.features,
    required this.requirements,
    required this.outcomes,
    required this.meta,
    required this.dates,
    required this.status,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
    excerpt: json["excerpt"],
    description: json["description"],
    shortDescription: json["short_description"],
    thumbnail: Thumbnail.fromJson(json["thumbnail"]),
    permalink: json["permalink"],
    pricing: Pricing.fromJson(json["pricing"]),
    enrollment: Enrollment.fromJson(json["enrollment"]),
    rating: Rating.fromJson(json["rating"]),
    courseInfo: CourseInfo.fromJson(json["course_info"]),
    author: Author.fromJson(json["author"]),
    categories: List<Category>.from(
      json["categories"].map((x) => Category.fromJson(x)),
    ),
    tags: List<dynamic>.from(json["tags"].map((x) => x)),
    features: List<dynamic>.from(json["features"].map((x) => x)),
    requirements: json["requirements"],
    outcomes: List<dynamic>.from(json["outcomes"].map((x) => x)),
    meta: Meta.fromJson(json["meta"]),
    dates: Dates.fromJson(json["dates"]),
    status: Status.fromJson(json["status"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "excerpt": excerpt,
    "description": description,
    "short_description": shortDescription,
    "thumbnail": thumbnail.toJson(),
    "permalink": permalink,
    "pricing": pricing.toJson(),
    "enrollment": enrollment.toJson(),
    "rating": rating.toJson(),
    "course_info": courseInfo.toJson(),
    "author": author.toJson(),
    "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
    "tags": List<dynamic>.from(tags.map((x) => x)),
    "features": List<dynamic>.from(features.map((x) => x)),
    "requirements": requirements,
    "outcomes": List<dynamic>.from(outcomes.map((x) => x)),
    "meta": meta.toJson(),
    "dates": dates.toJson(),
    "status": status.toJson(),
  };
}

class Author {
  int id;
  Name name;
  Username username;
  Email email;
  String avatarUrl;
  String profileUrl;
  String bio;
  String instructor;

  Author({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.avatarUrl,
    required this.profileUrl,
    required this.bio,
    required this.instructor,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
    id: json["id"],
    name: nameValues.map[json["name"]]!,
    username: usernameValues.map[json["username"]]!,
    email: emailValues.map[json["email"]]!,
    avatarUrl: json["avatar_url"],
    profileUrl: json["profile_url"],
    bio: json["bio"],
    instructor: json["instructor"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": nameValues.reverse[name],
    "username": usernameValues.reverse[username],
    "email": emailValues.reverse[email],
    "avatar_url": avatarUrl,
    "profile_url": profileUrl,
    "bio": bio,
    "instructor": instructor,
  };
}

enum Email { NAYNIL1033_GMAIL_COM }

final emailValues = EnumValues({
  "naynil1033@gmail.com": Email.NAYNIL1033_GMAIL_COM,
});

enum Name { ANIL_KUMAR_SINGH }

final nameValues = EnumValues({"Anil Kumar Singh": Name.ANIL_KUMAR_SINGH});

enum Username { ANIL }

final usernameValues = EnumValues({"anil": Username.ANIL});

class Category {
  int id;
  dynamic name;
  String slug;
  String url;

  Category({
    required this.id,
    required this.name,
    required this.slug,
    required this.url,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "url": url,
  };
}

class CourseInfo {
  Duration duration;
  Level level;
  String language;
  String certificate;
  String accessType;

  CourseInfo({
    required this.duration,
    required this.level,
    required this.language,
    required this.certificate,
    required this.accessType,
  });

  factory CourseInfo.fromJson(Map<String, dynamic> json) => CourseInfo(
    duration: Duration.fromJson(json["duration"]),
    level: levelValues.map[json["level"]]!,
    language: json["language"],
    certificate: json["certificate"],
    accessType: json["access_type"],
  );

  Map<String, dynamic> toJson() => {
    "duration": duration.toJson(),
    "level": levelValues.reverse[level],
    "language": language,
    "certificate": certificate,
    "access_type": accessType,
  };
}

class Duration {
  String hours;
  String minutes;

  Duration({required this.hours, required this.minutes});

  factory Duration.fromJson(Map<String, dynamic> json) =>
      Duration(hours: json["hours"], minutes: json["minutes"]);

  Map<String, dynamic> toJson() => {"hours": hours, "minutes": minutes};
}

enum Level { ALL_LEVELS, BEGINNER, INTERMEDIATE, beginner }

final levelValues = EnumValues({
  "all_levels": Level.ALL_LEVELS,
  "beginner": Level.BEGINNER,
  "intermediate": Level.INTERMEDIATE,
});

class Dates {
  DateTime created;
  DateTime modified;
  DateTime published;

  Dates({
    required this.created,
    required this.modified,
    required this.published,
  });

  factory Dates.fromJson(Map<String, dynamic> json) => Dates(
    created: DateTime.parse(json["created"]),
    modified: DateTime.parse(json["modified"]),
    published: DateTime.parse(json["published"]),
  );

  Map<String, dynamic> toJson() => {
    "created": created.toIso8601String(),
    "modified": modified.toIso8601String(),
    "published": published.toIso8601String(),
  };
}

class Enrollment {
  dynamic count;
  String maxStudents;
  String enrollmentType;

  Enrollment({
    required this.count,
    required this.maxStudents,
    required this.enrollmentType,
  });

  factory Enrollment.fromJson(Map<String, dynamic> json) => Enrollment(
    count: json["count"],
    maxStudents: json["max_students"],
    enrollmentType: json["enrollment_type"],
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "max_students": maxStudents,
    "enrollment_type": enrollmentType,
  };
}

class Meta {
  int totalLessons;
  dynamic totalTopics;
  int totalQuizzes;
  dynamic totalAssignments;
  dynamic totalVideos;
  dynamic totalAudio;

  Meta({
    required this.totalLessons,
    required this.totalTopics,
    required this.totalQuizzes,
    required this.totalAssignments,
    required this.totalVideos,
    required this.totalAudio,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    totalLessons: json["total_lessons"],
    totalTopics: json["total_topics"],
    totalQuizzes: json["total_quizzes"],
    totalAssignments: json["total_assignments"],
    totalVideos: json["total_videos"],
    totalAudio: json["total_audio"],
  );

  Map<String, dynamic> toJson() => {
    "total_lessons": totalLessons,
    "total_topics": totalTopics,
    "total_quizzes": totalQuizzes,
    "total_assignments": totalAssignments,
    "total_videos": totalVideos,
    "total_audio": totalAudio,
  };
}

class Pricing {
  int price;
  int salePrice;
  bool isFree;
  PriceLabel? priceLabel;
  Currency? currency;
  Symbol? symbol;

  Pricing({
    required this.price,
    required this.salePrice,
    required this.isFree,
    required this.priceLabel,
    required this.currency,
    this.symbol,
  });

  factory Pricing.fromJson(Map<String, dynamic> json) => Pricing(
    price: json["price"],
    salePrice: json["sale_price"],
    isFree: json["is_free"],
    // priceLabel: priceLabelValues.map[json["price_label"]]!,
    // currency: currencyValues.map[json["currency"]]!,
    priceLabel: priceLabelValues.map[json["price_label"]],
    currency: currencyValues.map[json["currency"]],
    symbol: symbolValues.map[json["symbol"]],
  );

  Map<String, dynamic> toJson() => {
    "price": price,
    "sale_price": salePrice,
    "is_free": isFree,
    // "price_label": priceLabelValues.reverse[priceLabel],
    // "currency": currencyValues.reverse[currency],
    "price_label": priceLabel != null
        ? priceLabelValues.reverse[priceLabel!]
        : null,
    "currency": currency != null ? currencyValues.reverse[currency!] : null,
    "symbol": symbolValues.reverse[symbol],
  };
}

enum Currency { INR }

final currencyValues = EnumValues({"INR": Currency.INR});

enum PriceLabel { FREE, PAID, SALE }

final priceLabelValues = EnumValues({
  "Free": PriceLabel.FREE,
  "Paid": PriceLabel.PAID,
  "Sale": PriceLabel.SALE,
});

enum Symbol { EMPTY }

final symbolValues = EnumValues({"\u0024": Symbol.EMPTY});

class Rating {
  Average average;
  String count;

  Rating({required this.average, required this.count});

  factory Rating.fromJson(Map<String, dynamic> json) =>
      Rating(average: Average.fromJson(json["average"]), count: json["count"]);

  Map<String, dynamic> toJson() => {
    "average": average.toJson(),
    "count": count,
  };
}

class Average {
  dynamic ratingCount;
  dynamic ratingSum;
  dynamic ratingAvg;
  Map<String, dynamic> countByValue;

  Average({
    required this.ratingCount,
    required this.ratingSum,
    required this.ratingAvg,
    required this.countByValue,
  });

  factory Average.fromJson(Map<String, dynamic> json) => Average(
    ratingCount: json["rating_count"],
    ratingSum: json["rating_sum"],
    ratingAvg: json["rating_avg"],
    countByValue: Map.from(
      json["count_by_value"],
    ).map((k, v) => MapEntry<String, dynamic>(k, v)),
  );

  Map<String, dynamic> toJson() => {
    "rating_count": ratingCount,
    "rating_sum": ratingSum,
    "rating_avg": ratingAvg,
    "count_by_value": Map.from(
      countByValue,
    ).map((k, v) => MapEntry<String, dynamic>(k, v)),
  };
}

class Status {
  bool published;
  String featured;
  String trending;

  Status({
    required this.published,
    required this.featured,
    required this.trending,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
    published: json["published"],
    featured: json["featured"],
    trending: json["trending"],
  );

  Map<String, dynamic> toJson() => {
    "published": published,
    "featured": featured,
    "trending": trending,
  };
}

class Thumbnail {
  String medium;
  String large;
  // String alt;

  Thumbnail({required this.medium, required this.large});

  factory Thumbnail.fromJson(Map<String, dynamic> json) =>
      Thumbnail(medium: json["medium"], large: json["large"]);

  Map<String, dynamic> toJson() => {
    "medium": medium,
    "large": large,
    // "alt": alt,
  };
}

class Filters {
  dynamic categoryId;
  dynamic search;
  dynamic priceType;
  Level level;
  String orderby;
  String order;

  Filters({
    required this.categoryId,
    required this.search,
    required this.priceType,
    required this.level,
    required this.orderby,
    required this.order,
  });

  factory Filters.fromJson(Map<String, dynamic> json) => Filters(
    categoryId: json["category_id"],
    search: json["search"],
    priceType: json["price_type"],
    level: levelValues.map[json["level"]] ?? Level.beginner,
    orderby: json["orderby"],
    order: json["order"],
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "search": search,
    "price_type": priceType,
    "level": levelValues.reverse[level],
    "orderby": orderby,
    "order": order,
  };
}

class Pagination {
  int currentPage;
  int perPage;
  int totalPosts;
  int totalPages;
  bool hasNextPage;
  bool hasPrevPage;
  // int nextPage;
  // dynamic prevPage;
  int? nextPage; // 👈 Nullable kar diya
  int? prevPage;

  Pagination({
    required this.currentPage,
    required this.perPage,
    required this.totalPosts,
    required this.totalPages,
    required this.hasNextPage,
    required this.hasPrevPage,
    // required this.nextPage,
    // required this.prevPage,
    this.nextPage, // 👈 null handle karega
    this.prevPage, // 👈 null handle karega
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    currentPage: json["current_page"],
    perPage: json["per_page"],
    totalPosts: json["total_posts"],
    totalPages: json["total_pages"],
    hasNextPage: json["has_next_page"],
    hasPrevPage: json["has_prev_page"],
    nextPage: json["next_page"],
    prevPage: json["prev_page"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "per_page": perPage,
    "total_posts": totalPosts,
    "total_pages": totalPages,
    "has_next_page": hasNextPage,
    "has_prev_page": hasPrevPage,
    "next_page": nextPage,
    "prev_page": prevPage,
  };
}

class Summary {
  int totalCourses;
  int freeCourses;
  int paidCourses;
  String currentPage;
  int showingFrom;
  int showingTo;

  Summary({
    required this.totalCourses,
    required this.freeCourses,
    required this.paidCourses,
    required this.currentPage,
    required this.showingFrom,
    required this.showingTo,
  });

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
    totalCourses: json["total_courses"],
    freeCourses: json["free_courses"],
    paidCourses: json["paid_courses"],
    currentPage: json["current_page"],
    showingFrom: json["showing_from"],
    showingTo: json["showing_to"],
  );

  Map<String, dynamic> toJson() => {
    "total_courses": totalCourses,
    "free_courses": freeCourses,
    "paid_courses": paidCourses,
    "current_page": currentPage,
    "showing_from": showingFrom,
    "showing_to": showingTo,
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

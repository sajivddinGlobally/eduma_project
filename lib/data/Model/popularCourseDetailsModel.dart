// import 'dart:convert';

// PopularCourseDetailsModel popularCourseDetailsModelFromJson(String str) =>
//     PopularCourseDetailsModel.fromJson(json.decode(str));

// String popularCourseDetailsModelToJson(PopularCourseDetailsModel? data) =>
//     json.encode(data?.toJson());

// class PopularCourseDetailsModel {
//   int? id;
//   String? title;
//   String? excerpt;
//   String? description;
//   String? thumbnail;
//   String? permalink;
//   String? price;
//   dynamic enrollCount;
//   Rating? rating;
//   dynamic popularityScore;
//   Author? author;
//   Map<String, List<String>>? meta;
//   List<Topic>? topics;

//   PopularCourseDetailsModel({
//     this.id,
//     this.title,
//     this.excerpt,
//     this.description,
//     this.thumbnail,
//     this.permalink,
//     this.price,
//     this.enrollCount,
//     this.rating,
//     this.popularityScore,
//     this.author,
//     this.meta,
//     this.topics,
//   });

//   factory PopularCourseDetailsModel.fromJson(
//     Map<String, dynamic>? json,
//   ) => PopularCourseDetailsModel(
//     id: _toInt(json?["id"]),
//     title: json?["title"]?.toString(),
//     excerpt: json?["excerpt"]?.toString(),
//     description: json?["description"]?.toString(),
//     thumbnail: json?["thumbnail"]?.toString(),
//     permalink: json?["permalink"]?.toString(),
//     price: json?["price"]?.toString(),
//     enrollCount: json?["enroll_count"],
//     rating: (json?["rating"] is Map) ? Rating.fromJson(json?["rating"]) : null,
//     popularityScore: json?["popularity_score"],
//     author: (json?["author"] is Map) ? Author.fromJson(json?["author"]) : null,
//     meta: (json?["meta"] is Map)
//         ? Map.from(json?["meta"]).map(
//             (k, v) => MapEntry<String, List<String>>(
//               k,
//               (v is List)
//                   ? v.map((x) => x.toString()).toList()
//                   : [v.toString()],
//             ),
//           )
//         : {},
//     topics: (json?["topics"] is List)
//         ? List<Topic>.from(
//             (json?["topics"] as List).map((x) => Topic.fromJson(x)),
//           )
//         : [],
//   );

//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "title": title,
//     "excerpt": excerpt,
//     "description": description,
//     "thumbnail": thumbnail,
//     "permalink": permalink,
//     "price": price,
//     "enroll_count": enrollCount,
//     "rating": rating?.toJson(),
//     "popularity_score": popularityScore,
//     "author": author?.toJson(),
//     "meta": meta != null
//         ? Map.from(meta!).map(
//             (k, v) => MapEntry<String, dynamic>(
//               k,
//               List<dynamic>.from(v.map((x) => x)),
//             ),
//           )
//         : {},
//     "topics": topics != null
//         ? List<dynamic>.from(topics!.map((x) => x.toJson()))
//         : [],
//   };
// }

// class Author {
//   int? id;
//   String? name;
//   String? avatarUrl;
//   String? phone;

//   Author({this.id, this.name, this.avatarUrl, this.phone});

//   factory Author.fromJson(Map<String, dynamic>? json) => Author(
//     id: _toInt(json?["id"]),
//     name: json?["name"]?.toString(),
//     avatarUrl: json?["avatar_url"]?.toString(),
//     phone: json?["phone"]?.toString(),
//   );

//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "avatar_url": avatarUrl,
//     "phone": phone,
//   };
// }

// class Rating {
//   int? ratingCount;
//   int? ratingSum;
//   double? ratingAvg;
//   Map<String, int>? countByValue;

//   Rating({this.ratingCount, this.ratingSum, this.ratingAvg, this.countByValue});

//   factory Rating.fromJson(Map<String, dynamic>? json) => Rating(
//     ratingCount: _toInt(json?["rating_count"]),
//     ratingSum: _toInt(json?["rating_sum"]),
//     ratingAvg: _toDouble(json?["rating_avg"]),
//     countByValue: (json?["count_by_value"] is Map)
//         ? Map.from(
//             json?["count_by_value"],
//           ).map((k, v) => MapEntry<String, int>(k, _toInt(v)))
//         : {},
//   );

//   Map<String, dynamic> toJson() => {
//     "rating_count": ratingCount,
//     "rating_sum": ratingSum,
//     "rating_avg": ratingAvg,
//     "count_by_value": countByValue ?? {},
//   };
// }

// class Topic {
//   String? topicId;
//   String? topicTitle;
//   String? topicContent;
//   List<dynamic>? topicMeta;
//   List<Lesson>? lessons;

//   Topic({
//     this.topicId,
//     this.topicTitle,
//     this.topicContent,
//     this.topicMeta,
//     this.lessons,
//   });

//   factory Topic.fromJson(Map<String, dynamic>? json) => Topic(
//     topicId: json?["topic_id"]?.toString(),
//     topicTitle: json?["topic_title"]?.toString(),
//     topicContent: json?["topic_content"]?.toString(),
//     topicMeta: (json?["topic_meta"] is List)
//         ? List<dynamic>.from(json?["topic_meta"].map((x) => x))
//         : [],
//     lessons: (json?["lessons"] is List)
//         ? List<Lesson>.from(
//             (json?["lessons"] as List).map((x) => Lesson.fromJson(x)),
//           )
//         : [],
//   );

//   Map<String, dynamic> toJson() => {
//     "topic_id": topicId,
//     "topic_title": topicTitle,
//     "topic_content": topicContent,
//     "topic_meta": topicMeta ?? [],
//     "lessons": lessons != null
//         ? List<dynamic>.from(lessons!.map((x) => x.toJson()))
//         : [],
//   };
// }

// class Lesson {
//   String? lessonId;
//   String? lessonTitle;
//   String? lessonContent;
//   LessonMeta? lessonMeta;
//   List<dynamic>? quizzes;
//   List<dynamic>? assignments;

//   Lesson({
//     this.lessonId,
//     this.lessonTitle,
//     this.lessonContent,
//     this.lessonMeta,
//     this.quizzes,
//     this.assignments,
//   });

//   factory Lesson.fromJson(Map<String, dynamic>? json) => Lesson(
//     lessonId: json?["lesson_id"]?.toString(),
//     lessonTitle: json?["lesson_title"]?.toString(),
//     lessonContent: json?["lesson_content"]?.toString(),
//     lessonMeta: (json?["lesson_meta"] is Map)
//         ? LessonMeta.fromJson(json?["lesson_meta"])
//         : null,
//     quizzes: (json?["quizzes"] is List)
//         ? List<dynamic>.from(json?["quizzes"].map((x) => x))
//         : [],
//     assignments: (json?["assignments"] is List)
//         ? List<dynamic>.from(json?["assignments"].map((x) => x))
//         : [],
//   );

//   Map<String, dynamic> toJson() => {
//     "lesson_id": lessonId,
//     "lesson_title": lessonTitle,
//     "lesson_content": lessonContent,
//     "lesson_meta": lessonMeta?.toJson(),
//     "quizzes": quizzes ?? [],
//     "assignments": assignments ?? [],
//   };
// }

// class LessonMeta {
//   List<String>? wpStatisticsWordsCount;
//   List<String>? thumbnailId;
//   List<String>? video;

//   LessonMeta({this.wpStatisticsWordsCount, this.thumbnailId, this.video});

//   factory LessonMeta.fromJson(Map<String, dynamic>? json) => LessonMeta(
//     wpStatisticsWordsCount: _safeList(json?["wp_statistics_words_count"]),
//     thumbnailId: _safeList(json?["_thumbnail_id"]),
//     video: _safeList(json?["_video"]),
//   );

//   Map<String, dynamic> toJson() => {
//     "wp_statistics_words_count": wpStatisticsWordsCount ?? [],
//     "_thumbnail_id": thumbnailId ?? [],
//     "_video": video ?? [],
//   };
// }

// /// 🔑 Helper Functions
// int _toInt(dynamic value) {
//   if (value == null) return 0;
//   if (value is int) return value;
//   if (value is String) return int.tryParse(value) ?? 0;
//   return 0;
// }

// double _toDouble(dynamic value) {
//   if (value == null) return 0.0;
//   if (value is double) return value;
//   if (value is int) return value.toDouble();
//   if (value is String) return double.tryParse(value) ?? 0.0;
//   return 0.0;
// }

// /// 🔒 Safe list converter
// List<String> _safeList(dynamic value) {
//   if (value == null) return [];
//   if (value is List) return value.map((e) => e.toString()).toList();
//   return [value.toString()];
// }


// To parse this JSON data, do
//
//     final popularCourseDetailsModel = popularCourseDetailsModelFromJson(jsonString);

import 'dart:convert';

PopularCourseDetailsModel popularCourseDetailsModelFromJson(String str) =>
    PopularCourseDetailsModel.fromJson(json.decode(str));

String popularCourseDetailsModelToJson(PopularCourseDetailsModel? data) =>
    json.encode(data?.toJson());

class PopularCourseDetailsModel {
  bool? success;
  int? id;
  String? title;
  String? url;
  String? thumbnail;
  String? description;
  String? content;
  String? price;
  String? regularPrice;
  String? salePrice;
  int? finalPrice;
  bool? isFree;
  String? courseType;
  String? currency;
  String? level;
  DurationModel? duration;
  dynamic enrollCount;
  Rating? rating;
  dynamic popularityScore;
  Instructor? instructor;
  List<Curriculum>? curriculum;
  int? totalTopics;
  int? totalLessons;
  EnrollmentStatus? enrollmentStatus;

  PopularCourseDetailsModel({
    this.success,
    this.id,
    this.title,
    this.url,
    this.thumbnail,
    this.description,
    this.content,
    this.price,
    this.regularPrice,
    this.salePrice,
    this.finalPrice,
    this.isFree,
    this.courseType,
    this.currency,
    this.level,
    this.duration,
    this.enrollCount,
    this.rating,
    this.popularityScore,
    this.instructor,
    this.curriculum,
    this.totalTopics,
    this.totalLessons,
    this.enrollmentStatus,
  });

  factory PopularCourseDetailsModel.fromJson(Map<String, dynamic>? json) =>
      PopularCourseDetailsModel(
        success: json?["success"] == true,
        id: _toInt(json?["id"]),
        title: json?["title"]?.toString(),
        url: json?["url"]?.toString(),
        thumbnail: json?["thumbnail"]?.toString(),
        description: json?["description"]?.toString(),
        content: json?["content"]?.toString(),
        price: json?["price"]?.toString(),
        regularPrice: json?["regular_price"]?.toString(),
        salePrice: json?["sale_price"]?.toString(),
        finalPrice: _toInt(json?["final_price"]),
        isFree: json?["is_free"] == true,
        courseType: json?["course_type"]?.toString(),
        currency: json?["currency"]?.toString(),
        level: json?["level"]?.toString(),
        duration: (json?["duration"] is Map)
            ? DurationModel.fromJson(json?["duration"])
            : null,
        enrollCount: json?["enroll_count"],
        rating:
            (json?["rating"] is Map) ? Rating.fromJson(json?["rating"]) : null,
        popularityScore: json?["popularity_score"],
        instructor: (json?["instructor"] is Map)
            ? Instructor.fromJson(json?["instructor"])
            : null,
        curriculum: (json?["curriculum"] is List)
            ? List<Curriculum>.from(
                (json?["curriculum"] as List)
                    .map((x) => Curriculum.fromJson(x)),
              )
            : [],
        totalTopics: _toInt(json?["total_topics"]),
        totalLessons: _toInt(json?["total_lessons"]),
        enrollmentStatus: (json?["enrollment_status"] is Map)
            ? EnrollmentStatus.fromJson(json?["enrollment_status"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "id": id,
        "title": title,
        "url": url,
        "thumbnail": thumbnail,
        "description": description,
        "content": content,
        "price": price,
        "regular_price": regularPrice,
        "sale_price": salePrice,
        "final_price": finalPrice,
        "is_free": isFree,
        "course_type": courseType,
        "currency": currency,
        "level": level,
        "duration": duration?.toJson(),
        "enroll_count": enrollCount,
        "rating": rating?.toJson(),
        "popularity_score": popularityScore,
        "instructor": instructor?.toJson(),
        "curriculum": curriculum != null
            ? List<dynamic>.from(curriculum!.map((x) => x.toJson()))
            : [],
        "total_topics": totalTopics,
        "total_lessons": totalLessons,
        "enrollment_status": enrollmentStatus?.toJson(),
      };
}

class Curriculum {
  String? topicId;
  String? topicTitle;
  String? topicContent;
  List<Lesson>? lessons;

  Curriculum({this.topicId, this.topicTitle, this.topicContent, this.lessons});

  factory Curriculum.fromJson(Map<String, dynamic>? json) => Curriculum(
        topicId: json?["topic_id"]?.toString(),
        topicTitle: json?["topic_title"]?.toString(),
        topicContent: json?["topic_content"]?.toString(),
        lessons: (json?["lessons"] is List)
            ? List<Lesson>.from(
                (json?["lessons"] as List).map((x) => Lesson.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "topic_id": topicId,
        "topic_title": topicTitle,
        "topic_content": topicContent,
        "lessons": lessons != null
            ? List<dynamic>.from(lessons!.map((x) => x.toJson()))
            : [],
      };
}

class Lesson {
  String? lessonId;
  String? lessonTitle;
  String? lessonContent;
  String? lessonExcerpt;
  bool? featuredImage;
  Video? video;
  List<dynamic>? attachments;
  String? duration;
  List<dynamic>? quizzes;
  List<dynamic>? assignments;

  Lesson({
    this.lessonId,
    this.lessonTitle,
    this.lessonContent,
    this.lessonExcerpt,
    this.featuredImage,
    this.video,
    this.attachments,
    this.duration,
    this.quizzes,
    this.assignments,
  });

  factory Lesson.fromJson(Map<String, dynamic>? json) => Lesson(
        lessonId: json?["lesson_id"]?.toString(),
        lessonTitle: json?["lesson_title"]?.toString(),
        lessonContent: json?["lesson_content"]?.toString(),
        lessonExcerpt: json?["lesson_excerpt"]?.toString(),
        featuredImage: json?["featured_image"] == true,
        video:
            (json?["video"] is Map) ? Video.fromJson(json?["video"]) : null,
        attachments: (json?["attachments"] is List)
            ? List<dynamic>.from(json?["attachments"].map((x) => x))
            : [],
        duration: json?["duration"]?.toString(),
        quizzes: (json?["quizzes"] is List)
            ? List<dynamic>.from(json?["quizzes"].map((x) => x))
            : [],
        assignments: (json?["assignments"] is List)
            ? List<dynamic>.from(json?["assignments"].map((x) => x))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "lesson_id": lessonId,
        "lesson_title": lessonTitle,
        "lesson_content": lessonContent,
        "lesson_excerpt": lessonExcerpt,
        "featured_image": featuredImage,
        "video": video?.toJson(),
        "attachments": attachments ?? [],
        "duration": duration,
        "quizzes": quizzes ?? [],
        "assignments": assignments ?? [],
      };
}

class Video {
  String? source;
  String? url;
  Runtime? runtime;

  Video({this.source, this.url, this.runtime});

  factory Video.fromJson(Map<String, dynamic>? json) => Video(
        source: json?["source"]?.toString(),
        url: json?["url"]?.toString(),
        runtime:
            (json?["runtime"] is Map) ? Runtime.fromJson(json?["runtime"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "source": source,
        "url": url,
        "runtime": runtime?.toJson(),
      };
}

class Runtime {
  String? hours;
  String? minutes;
  String? seconds;

  Runtime({this.hours, this.minutes, this.seconds});

  factory Runtime.fromJson(Map<String, dynamic>? json) => Runtime(
        hours: json?["hours"]?.toString(),
        minutes: json?["minutes"]?.toString(),
        seconds: json?["seconds"]?.toString(),
      );

  Map<String, dynamic> toJson() =>
      {"hours": hours, "minutes": minutes, "seconds": seconds};
}

class DurationModel {
  String? hours;
  String? minutes;

  DurationModel({this.hours, this.minutes});

  factory DurationModel.fromJson(Map<String, dynamic>? json) => DurationModel(
        hours: json?["hours"]?.toString(),
        minutes: json?["minutes"]?.toString(),
      );

  Map<String, dynamic> toJson() => {"hours": hours, "minutes": minutes};
}

class EnrollmentStatus {
  bool? isEnrolled;
  bool? canEnroll;

  EnrollmentStatus({this.isEnrolled, this.canEnroll});

  factory EnrollmentStatus.fromJson(Map<String, dynamic>? json) =>
      EnrollmentStatus(
        isEnrolled: json?["is_enrolled"] == true,
        canEnroll: json?["can_enroll"] == true,
      );

  Map<String, dynamic> toJson() =>
      {"is_enrolled": isEnrolled, "can_enroll": canEnroll};
}

class Instructor {
  int? id;
  String? name;
  String? email;
  String? bio;
  String? avatar;
  String? phone;

  Instructor({this.id, this.name, this.email, this.bio, this.avatar, this.phone});

  factory Instructor.fromJson(Map<String, dynamic>? json) => Instructor(
        id: _toInt(json?["id"]),
        name: json?["name"]?.toString(),
        email: json?["email"]?.toString(),
        bio: json?["bio"]?.toString(),
        avatar: json?["avatar"]?.toString(),
        phone: json?["phone"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "bio": bio,
        "avatar": avatar,
        "phone": phone,
      };
}

class Rating {
  int? ratingCount;
  int? ratingSum;
  int? ratingAvg;
  Map<String, int>? countByValue;

  Rating({this.ratingCount, this.ratingSum, this.ratingAvg, this.countByValue});

  factory Rating.fromJson(Map<String, dynamic>? json) => Rating(
        ratingCount: _toInt(json?["rating_count"]),
        ratingSum: _toInt(json?["rating_sum"]),
        ratingAvg: _toInt(json?["rating_avg"]),
        countByValue: (json?["count_by_value"] is Map)
            ? Map.from(json?["count_by_value"])
                .map((k, v) => MapEntry<String, int>(k, _toInt(v)))
            : {},
      );

  Map<String, dynamic> toJson() => {
        "rating_count": ratingCount,
        "rating_sum": ratingSum,
        "rating_avg": ratingAvg,
        "count_by_value": countByValue ?? {},
      };
}

/// 🔑 Helper Functions
int _toInt(dynamic value) {
  if (value == null) return 0;
  if (value is int) return value;
  if (value is String) return int.tryParse(value) ?? 0;
  return 0;
}

double _toDouble(dynamic value) {
  if (value == null) return 0.0;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is String) return double.tryParse(value) ?? 0.0;
  return 0.0;
}

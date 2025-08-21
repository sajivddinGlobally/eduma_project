import 'dart:convert';

PopularCourseDetailsModel popularCourseDetailsModelFromJson(String str) =>
    PopularCourseDetailsModel.fromJson(json.decode(str));

String popularCourseDetailsModelToJson(PopularCourseDetailsModel data) =>
    json.encode(data.toJson());

class PopularCourseDetailsModel {
  int id;
  String title;
  String excerpt;
  String description;
  String thumbnail;
  String permalink;
  String price;
  dynamic enrollCount;
  Rating rating;
  dynamic popularityScore;
  Author author;
  Map<String, List<String>> meta;
  List<Topic> topics;

  PopularCourseDetailsModel({
    required this.id,
    required this.title,
    required this.excerpt,
    required this.description,
    required this.thumbnail,
    required this.permalink,
    required this.price,
    required this.enrollCount,
    required this.rating,
    required this.popularityScore,
    required this.author,
    required this.meta,
    required this.topics,
  });

  factory PopularCourseDetailsModel.fromJson(Map<String, dynamic> json) =>
      PopularCourseDetailsModel(
        id: _toInt(json["id"]),
        title: json["title"]?.toString() ?? "",
        excerpt: json["excerpt"]?.toString() ?? "",
        description: json["description"]?.toString() ?? "",
        thumbnail: json["thumbnail"]?.toString() ?? "",
        permalink: json["permalink"]?.toString() ?? "",
        price: json["price"]?.toString() ?? "0",
        enrollCount: json["enroll_count"],
      //  rating: Rating.fromJson(json["rating"] ?? {}),
      rating: (json["rating"] is Map)
    ? Rating.fromJson(json["rating"])
    : Rating.fromJson({}),
        popularityScore: json["popularity_score"],
        author: Author.fromJson(json["author"] ?? {}),
        // meta: Map.from(json["meta"] ?? {}).map(
        //   (k, v) => MapEntry<String, List<String>>(
        //     k,
        //     List<String>.from((v ?? []).map((x) => x.toString())),
        //   ),
        // ),

        meta: (json["meta"] is Map)
    ? Map.from(json["meta"]).map(
        (k, v) => MapEntry<String, List<String>>(
          k,
          (v is List)
              ? v.map((x) => x.toString()).toList()
              : [v.toString()],
        ),
      )
    : {},


        // topics: List<Topic>.from(
        //   (json["topics"] ?? []).map((x) => Topic.fromJson(x)),
        // ),
        topics: (json["topics"] is List)
    ? List<Topic>.from((json["topics"] as List).map((x) => Topic.fromJson(x)))
    : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "excerpt": excerpt,
        "description": description,
        "thumbnail": thumbnail,
        "permalink": permalink,
        "price": price,
        "enroll_count": enrollCount,
        "rating": rating.toJson(),
        "popularity_score": popularityScore,
        "author": author.toJson(),
        "meta": Map.from(meta).map(
          (k, v) =>
              MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x))),
        ),
        "topics": List<dynamic>.from(topics.map((x) => x.toJson())),
      };
}

class Author {
  int id;
  String name;
  String avatarUrl;
  String phone;

  Author({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.phone,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        id: _toInt(json["id"]),
        name: json["name"]?.toString() ?? "",
        avatarUrl: json["avatar_url"]?.toString() ?? "",
        phone: json["phone"]?.toString() ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "avatar_url": avatarUrl,
        "phone": phone,
      };
}

class Rating {
  int ratingCount;
  int ratingSum;
  double ratingAvg;
  Map<String, int> countByValue;

  Rating({
    required this.ratingCount,
    required this.ratingSum,
    required this.ratingAvg,
    required this.countByValue,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        ratingCount: _toInt(json["rating_count"]),
        ratingSum: _toInt(json["rating_sum"]),
        ratingAvg: _toDouble(json["rating_avg"]),
        countByValue: Map.from(
          json["count_by_value"] ?? {},
        ).map((k, v) => MapEntry<String, int>(k, _toInt(v))),
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

class Topic {
  String topicId;
  String topicTitle;
  String topicContent;
  List<dynamic> topicMeta;
  List<Lesson> lessons;

  Topic({
    required this.topicId,
    required this.topicTitle,
    required this.topicContent,
    required this.topicMeta,
    required this.lessons,
  });

  factory Topic.fromJson(Map<String, dynamic> json) => Topic(
        topicId: json["topic_id"]?.toString() ?? "",
        topicTitle: json["topic_title"]?.toString() ?? "",
        topicContent: json["topic_content"]?.toString() ?? "",
        topicMeta: List<dynamic>.from((json["topic_meta"] ?? []).map((x) => x)),
        lessons: List<Lesson>.from(
          (json["lessons"] ?? []).map((x) => Lesson.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        "topic_id": topicId,
        "topic_title": topicTitle,
        "topic_content": topicContent,
        "topic_meta": List<dynamic>.from(topicMeta.map((x) => x)),
        "lessons": List<dynamic>.from(lessons.map((x) => x.toJson())),
      };
}

class Lesson {
  String lessonId;
  String lessonTitle;
  String lessonContent;
  LessonMeta lessonMeta;
  List<dynamic> quizzes;
  List<dynamic> assignments;

  Lesson({
    required this.lessonId,
    required this.lessonTitle,
    required this.lessonContent,
    required this.lessonMeta,
    required this.quizzes,
    required this.assignments,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
        lessonId: json["lesson_id"]?.toString() ?? "",
        lessonTitle: json["lesson_title"]?.toString() ?? "",
        lessonContent: json["lesson_content"]?.toString() ?? "",
        lessonMeta: LessonMeta.fromJson(json["lesson_meta"] ?? {}),
        quizzes: List<dynamic>.from((json["quizzes"] ?? []).map((x) => x)),
        assignments:
            List<dynamic>.from((json["assignments"] ?? []).map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "lesson_id": lessonId,
        "lesson_title": lessonTitle,
        "lesson_content": lessonContent,
        "lesson_meta": lessonMeta.toJson(),
        "quizzes": List<dynamic>.from(quizzes.map((x) => x)),
        "assignments": List<dynamic>.from(assignments.map((x) => x)),
      };
}

class LessonMeta {
  List<String> wpStatisticsWordsCount;
  List<String> thumbnailId;
  List<String> video;

  LessonMeta({
    required this.wpStatisticsWordsCount,
    required this.thumbnailId,
    required this.video,
  });

  factory LessonMeta.fromJson(Map<String, dynamic> json) => LessonMeta(
        wpStatisticsWordsCount: _safeList(json["wp_statistics_words_count"]),
        thumbnailId: _safeList(json["_thumbnail_id"]),
        video: _safeList(json["_video"]),
      );

  Map<String, dynamic> toJson() => {
        "wp_statistics_words_count":
            List<dynamic>.from(wpStatisticsWordsCount.map((x) => x)),
        "_thumbnail_id": List<dynamic>.from(thumbnailId.map((x) => x)),
        "_video": List<dynamic>.from(video.map((x) => x)),
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

/// 🔒 Safe list converter (koi bhi type aaye → string list bana do)
List<String> _safeList(dynamic value) {
  if (value == null) return [];
  if (value is List) return value.map((e) => e.toString()).toList();
  return [value.toString()];
}

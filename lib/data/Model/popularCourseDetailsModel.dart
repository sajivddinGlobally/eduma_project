import 'dart:convert';

PopularCourseDetailsModel popularCourseDetailsModelFromJson(String str) =>
    PopularCourseDetailsModel.fromJson(json.decode(str));

String popularCourseDetailsModelToJson(PopularCourseDetailsModel? data) =>
    json.encode(data?.toJson());

class PopularCourseDetailsModel {
  int? id;
  String? title;
  String? excerpt;
  String? description;
  String? thumbnail;
  String? permalink;
  String? price;
  dynamic enrollCount;
  Rating? rating;
  dynamic popularityScore;
  Author? author;
  Map<String, List<String>>? meta;
  List<Topic>? topics;
  Direction? direction; // 🔹 Direction object add kiya
  List<String>? courseOverview;
  
  PopularCourseDetailsModel({
    this.id,
    this.title,
    this.excerpt,
    this.description,
    this.thumbnail,
    this.permalink,
    this.price,
    this.enrollCount,
    this.rating,
    this.popularityScore,
    this.author,
    this.meta,
    this.topics,
    this.direction,
     this.courseOverview,
  });

  factory PopularCourseDetailsModel.fromJson(
    Map<String, dynamic>? json,
  ) => PopularCourseDetailsModel(
    id: _toInt(json?["id"]),
    title: json?["title"]?.toString(),
    excerpt: json?["excerpt"]?.toString(),
    description: json?["description"]?.toString(),
    thumbnail: json?["thumbnail"]?.toString(),
    permalink: json?["permalink"]?.toString(),
    price: json?["price"]?.toString(),
    enrollCount: json?["enroll_count"],
    rating: (json?["rating"] is Map) ? Rating.fromJson(json?["rating"]) : null,
    popularityScore: json?["popularity_score"],
    author: (json?["author"] is Map) ? Author.fromJson(json?["author"]) : null,
    meta: (json?["meta"] is Map)
        ? Map.from(json?["meta"]).map(
            (k, v) => MapEntry<String, List<String>>(
              k,
              (v is List)
                  ? v.map((x) => x.toString()).toList()
                  : [v.toString()],
            ),
          )
        : {},
    topics: (json?["topics"] is List)
        ? List<Topic>.from(
            (json?["topics"] as List).map((x) => Topic.fromJson(x)),
          )
        : [],
    direction:
        (json?["direction"] is Map) // 🔹 parse direction
        ? Direction.fromJson(json?["direction"])
        : null,
        courseOverview: json!['course_overview'] != null
          ? List<String>.from(json['course_overview'])
          : [], // 👈 safe list banayi
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
    "rating": rating?.toJson(),
    "popularity_score": popularityScore,
    "author": author?.toJson(),
    "meta": meta != null
        ? Map.from(meta!).map(
            (k, v) => MapEntry<String, dynamic>(
              k,
              List<dynamic>.from(v.map((x) => x)),
            ),
          )
        : {},
    "topics": topics != null
        ? List<dynamic>.from(topics!.map((x) => x.toJson()))
        : [],
    "direction": direction?.toJson(), // 🔹 add in json
    'course_overview': courseOverview ?? [],
  };
}

class Direction {
  int? hours;
  int? minutes;

  Direction({this.hours, this.minutes});

  factory Direction.fromJson(Map<String, dynamic>? json) => Direction(
    hours: _toInt(json?["hours"]),
    minutes: _toInt(json?["minutes"]),
  );

  Map<String, dynamic> toJson() => {"hours": hours, "minutes": minutes};
}

class Author {
  int? id;
  String? name;
  String? avatarUrl;
  String? phone;

  Author({this.id, this.name, this.avatarUrl, this.phone});

  factory Author.fromJson(Map<String, dynamic>? json) => Author(
    id: _toInt(json?["id"]),
    name: json?["name"]?.toString(),
    avatarUrl: json?["avatar_url"]?.toString(),
    phone: json?["phone"]?.toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "avatar_url": avatarUrl,
    "phone": phone,
  };
}

class Rating {
  int? ratingCount;
  int? ratingSum;
  double? ratingAvg;
  Map<String, int>? countByValue;

  Rating({this.ratingCount, this.ratingSum, this.ratingAvg, this.countByValue});

  factory Rating.fromJson(Map<String, dynamic>? json) => Rating(
    ratingCount: _toInt(json?["rating_count"]),
    ratingSum: _toInt(json?["rating_sum"]),
    ratingAvg: _toDouble(json?["rating_avg"]),
    countByValue: (json?["count_by_value"] is Map)
        ? Map.from(
            json?["count_by_value"],
          ).map((k, v) => MapEntry<String, int>(k, _toInt(v)))
        : {},
  );

  Map<String, dynamic> toJson() => {
    "rating_count": ratingCount,
    "rating_sum": ratingSum,
    "rating_avg": ratingAvg,
    "count_by_value": countByValue ?? {},
  };
}

class Topic {
  String? topicId;
  String? topicTitle;
  String? topicContent;
  List<dynamic>? topicMeta;
  List<Lesson>? lessons;

  Topic({
    this.topicId,
    this.topicTitle,
    this.topicContent,
    this.topicMeta,
    this.lessons,
  });

  factory Topic.fromJson(Map<String, dynamic>? json) => Topic(
    topicId: json?["topic_id"]?.toString(),
    topicTitle: json?["topic_title"]?.toString(),
    topicContent: json?["topic_content"]?.toString(),
    topicMeta: (json?["topic_meta"] is List)
        ? List<dynamic>.from(json?["topic_meta"].map((x) => x))
        : [],
    lessons: (json?["lessons"] is List)
        ? List<Lesson>.from(
            (json?["lessons"] as List).map((x) => Lesson.fromJson(x)),
          )
        : [],
  );

  Map<String, dynamic> toJson() => {
    "topic_id": topicId,
    "topic_title": topicTitle,
    "topic_content": topicContent,
    "topic_meta": topicMeta ?? [],
    "lessons": lessons != null
        ? List<dynamic>.from(lessons!.map((x) => x.toJson()))
        : [],
  };
}

class Lesson {
  String? lessonId;
  String? lessonTitle;
  String? lessonContent;
  LessonMeta? lessonMeta;
  List<Attachment>? attachments; // 🔹 Added
  List<dynamic>? quizzes;
  List<dynamic>? assignments;

  Lesson({
    this.lessonId,
    this.lessonTitle,
    this.lessonContent,
    this.lessonMeta,
    this.attachments, // 🔹 Added
    this.quizzes,
    this.assignments,
  });

  factory Lesson.fromJson(Map<String, dynamic>? json) => Lesson(
    lessonId: json?["lesson_id"]?.toString(),
    lessonTitle: json?["lesson_title"]?.toString(),
    lessonContent: json?["lesson_content"]?.toString(),
    lessonMeta: (json?["lesson_meta"] is Map)
        ? LessonMeta.fromJson(json?["lesson_meta"])
        : null,
    attachments:
        (json?["attachments"] is List) // 🔹 Added
        ? List<Attachment>.from(
            (json?["attachments"] as List).map((x) => Attachment.fromJson(x)),
          )
        : [],
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
    "lesson_meta": lessonMeta?.toJson(),
    "attachments":
        attachments !=
            null // 🔹 Added
        ? List<dynamic>.from(attachments!.map((x) => x.toJson()))
        : [],
    "quizzes": quizzes ?? [],
    "assignments": assignments ?? [],
  };
}

class LessonMeta {
  List<String>? wpStatisticsWordsCount;
  List<String>? thumbnailId;
  List<String>? video;

  LessonMeta({this.wpStatisticsWordsCount, this.thumbnailId, this.video});

  factory LessonMeta.fromJson(Map<String, dynamic>? json) => LessonMeta(
    wpStatisticsWordsCount: _safeList(json?["wp_statistics_words_count"]),
    thumbnailId: _safeList(json?["_thumbnail_id"]),
    video: _safeList(json?["_video"]),
  );

  Map<String, dynamic> toJson() => {
    "wp_statistics_words_count": wpStatisticsWordsCount ?? [],
    "_thumbnail_id": thumbnailId ?? [],
    "_video": video ?? [],
  };
}

// 🔹 NEW Attachment Class Added
class Attachment {
  String? id;
  String? title;
  String? url;
  String? type;

  Attachment({this.id, this.title, this.url, this.type});

  factory Attachment.fromJson(Map<String, dynamic>? json) => Attachment(
    id: json?["id"]?.toString(),
    title: json?["title"]?.toString(),
    url: json?["url"]?.toString(),
    type: json?["type"]?.toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "url": url,
    "type": type,
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

/// 🔒 Safe list converter
List<String> _safeList(dynamic value) {
  if (value == null) return [];
  if (value is List) return value.map((e) => e.toString()).toList();
  return [value.toString()];
}

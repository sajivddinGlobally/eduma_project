// To parse this JSON data, do
//
//     final popularCourseDetailsModel = popularCourseDetailsModelFromJson(jsonString);

import 'dart:convert';

PopularCourseDetailsModel popularCourseDetailsModelFromJson(String str) => PopularCourseDetailsModel.fromJson(json.decode(str));

String popularCourseDetailsModelToJson(PopularCourseDetailsModel data) => json.encode(data.toJson());

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

    factory PopularCourseDetailsModel.fromJson(Map<String, dynamic> json) => PopularCourseDetailsModel(
        id: json["id"],
        title: json["title"],
        excerpt: json["excerpt"],
        description: json["description"],
        thumbnail: json["thumbnail"],
        permalink: json["permalink"],
        price: json["price"],
        enrollCount: json["enroll_count"],
        rating: Rating.fromJson(json["rating"]),
        popularityScore: json["popularity_score"],
        author: Author.fromJson(json["author"]),
        meta: Map.from(json["meta"]).map((k, v) => MapEntry<String, List<String>>(k, List<String>.from(v.map((x) => x)))),
        topics: List<Topic>.from(json["topics"].map((x) => Topic.fromJson(x))),
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
        "meta": Map.from(meta).map((k, v) => MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x)))),
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
        id: json["id"],
        name: json["name"],
        avatarUrl: json["avatar_url"],
        phone: json["phone"],
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
        topicId: json["topic_id"],
        topicTitle: json["topic_title"],
        topicContent: json["topic_content"],
        topicMeta: List<dynamic>.from(json["topic_meta"].map((x) => x)),
        lessons: List<Lesson>.from(json["lessons"].map((x) => Lesson.fromJson(x))),
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
        lessonId: json["lesson_id"],
        lessonTitle: json["lesson_title"],
        lessonContent: json["lesson_content"],
        lessonMeta: LessonMeta.fromJson(json["lesson_meta"]),
        quizzes: List<dynamic>.from(json["quizzes"].map((x) => x)),
        assignments: List<dynamic>.from(json["assignments"].map((x) => x)),
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
    List<String>? thumbnailId;
    List<String>? video;

    LessonMeta({
        required this.wpStatisticsWordsCount,
        this.thumbnailId,
        this.video,
    });

    factory LessonMeta.fromJson(Map<String, dynamic> json) => LessonMeta(
        wpStatisticsWordsCount: List<String>.from(json["wp_statistics_words_count"].map((x) => x)),
        thumbnailId: json["_thumbnail_id"] == null ? [] : List<String>.from(json["_thumbnail_id"]!.map((x) => x)),
        video: json["_video"] == null ? [] : List<String>.from(json["_video"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "wp_statistics_words_count": List<dynamic>.from(wpStatisticsWordsCount.map((x) => x)),
        "_thumbnail_id": thumbnailId == null ? [] : List<dynamic>.from(thumbnailId!.map((x) => x)),
        "_video": video == null ? [] : List<dynamic>.from(video!.map((x) => x)),
    };
}

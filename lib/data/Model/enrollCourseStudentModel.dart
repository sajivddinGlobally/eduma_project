// To parse this JSON data, do
//
//     final enrolleCourseStudentModel = enrolleCourseStudentModelFromJson(jsonString);

import 'dart:convert';

EnrolleCourseStudentModel enrolleCourseStudentModelFromJson(String str) => EnrolleCourseStudentModel.fromJson(json.decode(str));

String enrolleCourseStudentModelToJson(EnrolleCourseStudentModel data) => json.encode(data.toJson());

class EnrolleCourseStudentModel {
    bool success;
    int totalCourses;
    List<Course> courses;
    int userId;

    EnrolleCourseStudentModel({
        required this.success,
        required this.totalCourses,
        required this.courses,
        required this.userId,
    });

    factory EnrolleCourseStudentModel.fromJson(Map<String, dynamic> json) => EnrolleCourseStudentModel(
        success: json["success"],
        totalCourses: json["total_courses"],
        courses: List<Course>.from(json["courses"].map((x) => Course.fromJson(x))),
        userId: json["user_id"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "total_courses": totalCourses,
        "courses": List<dynamic>.from(courses.map((x) => x.toJson())),
        "user_id": userId,
    };
}

class Course {
    int id;
    String title;
    String url;
    String thumbnail;
    String description;
    String content;
    String price;
    String priceType;
    String regularPrice;
    String salePrice;
    DateTime enrollmentDate;
    int progress;
    Instructor instructor;
    Stats stats;
    List<Curriculum> curriculum;
    List<String> categories;
    List<dynamic> tags;
    int totalTopics;
    int completedLessons;
    dynamic certificateUrl;

    Course({
        required this.id,
        required this.title,
        required this.url,
        required this.thumbnail,
        required this.description,
        required this.content,
        required this.price,
        required this.priceType,
        required this.regularPrice,
        required this.salePrice,
        required this.enrollmentDate,
        required this.progress,
        required this.instructor,
        required this.stats,
        required this.curriculum,
        required this.categories,
        required this.tags,
        required this.totalTopics,
        required this.completedLessons,
        required this.certificateUrl,
    });

    factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json["id"],
        title: json["title"],
        url: json["url"],
        thumbnail: json["thumbnail"],
        description: json["description"],
        content: json["content"],
        price: json["price"],
        priceType: json["price_type"],
        regularPrice: json["regular_price"],
        salePrice: json["sale_price"],
        enrollmentDate: DateTime.parse(json["enrollment_date"]),
        progress: json["progress"],
        instructor: Instructor.fromJson(json["instructor"]),
        stats: Stats.fromJson(json["stats"]),
        curriculum: List<Curriculum>.from(json["curriculum"].map((x) => Curriculum.fromJson(x))),
        categories: List<String>.from(json["categories"].map((x) => x)),
        tags: List<dynamic>.from(json["tags"].map((x) => x)),
        totalTopics: json["total_topics"],
        completedLessons: json["completed_lessons"],
        certificateUrl: json["certificate_url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "url": url,
        "thumbnail": thumbnail,
        "description": description,
        "content": content,
        "price": price,
        "price_type": priceType,
        "regular_price": regularPrice,
        "sale_price": salePrice,
        "enrollment_date": enrollmentDate.toIso8601String(),
        "progress": progress,
        "instructor": instructor.toJson(),
        "stats": stats.toJson(),
        "curriculum": List<dynamic>.from(curriculum.map((x) => x.toJson())),
        "categories": List<dynamic>.from(categories.map((x) => x)),
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "total_topics": totalTopics,
        "completed_lessons": completedLessons,
        "certificate_url": certificateUrl,
    };
}

class Curriculum {
    int topicId;
    String topicTitle;
    String topicSummary;
    List<Lesson> lessons;
    int totalLessons;

    Curriculum({
        required this.topicId,
        required this.topicTitle,
        required this.topicSummary,
        required this.lessons,
        required this.totalLessons,
    });

    factory Curriculum.fromJson(Map<String, dynamic> json) => Curriculum(
        topicId: json["topic_id"],
        topicTitle: json["topic_title"],
        topicSummary: json["topic_summary"],
        lessons: List<Lesson>.from(json["lessons"].map((x) => Lesson.fromJson(x))),
        totalLessons: json["total_lessons"],
    );

    Map<String, dynamic> toJson() => {
        "topic_id": topicId,
        "topic_title": topicTitle,
        "topic_summary": topicSummary,
        "lessons": List<dynamic>.from(lessons.map((x) => x.toJson())),
        "total_lessons": totalLessons,
    };
}

class Lesson {
    int id;
    String title;
    LessonType type;
    String url;
    bool isCompleted;
    String duration;
    dynamic preview;
    Video video;

    Lesson({
        required this.id,
        required this.title,
        required this.type,
        required this.url,
        required this.isCompleted,
        required this.duration,
        required this.preview,
        required this.video,
    });

    factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
        id: json["id"],
        title: json["title"],
        type: lessonTypeValues.map[json["type"]]!,
        url: json["url"],
        isCompleted: json["is_completed"],
        duration: json["duration"],
        preview: json["preview"],
        video: Video.fromJson(json["video"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "type": lessonTypeValues.reverse[type],
        "url": url,
        "is_completed": isCompleted,
        "duration": duration,
        "preview": preview,
        "video": video.toJson(),
    };
}

enum LessonType {
    LESSON
}

final lessonTypeValues = EnumValues({
    "lesson": LessonType.LESSON
});

class Video {
    String source;
    String url;
    VideoType type;
    String duration;
    String poster;

    Video({
        required this.source,
        required this.url,
        required this.type,
        required this.duration,
        required this.poster,
    });

    factory Video.fromJson(Map<String, dynamic> json) => Video(
        source: json["source"],
        url: json["url"],
        type: videoTypeValues.map[json["type"]]!,
        duration: json["duration"],
        poster: json["poster"],
    );

    Map<String, dynamic> toJson() => {
        "source": source,
        "url": url,
        "type": videoTypeValues.reverse[type],
        "duration": duration,
        "poster": poster,
    };
}

enum VideoType {
    NONE
}

final videoTypeValues = EnumValues({
    "none": VideoType.NONE
});

class Instructor {
    String id;
    String name;
    String email;
    String bio;
    String avatar;
    String profileUrl;

    Instructor({
        required this.id,
        required this.name,
        required this.email,
        required this.bio,
        required this.avatar,
        required this.profileUrl,
    });

    factory Instructor.fromJson(Map<String, dynamic> json) => Instructor(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        bio: json["bio"],
        avatar: json["avatar"],
        profileUrl: json["profile_url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "bio": bio,
        "avatar": avatar,
        "profile_url": profileUrl,
    };
}

class Stats {
    int totalStudents;
    int totalLessons;
    TotalDuration totalDuration;
    String difficultyLevel;
    CourseRating courseRating;
    dynamic totalReviews;

    Stats({
        required this.totalStudents,
        required this.totalLessons,
        required this.totalDuration,
        required this.difficultyLevel,
        required this.courseRating,
        required this.totalReviews,
    });

    factory Stats.fromJson(Map<String, dynamic> json) => Stats(
        totalStudents: json["total_students"],
        totalLessons: json["total_lessons"],
        totalDuration: TotalDuration.fromJson(json["total_duration"]),
        difficultyLevel: json["difficulty_level"],
        courseRating: CourseRating.fromJson(json["course_rating"]),
        totalReviews: json["total_reviews"],
    );

    Map<String, dynamic> toJson() => {
        "total_students": totalStudents,
        "total_lessons": totalLessons,
        "total_duration": totalDuration.toJson(),
        "difficulty_level": difficultyLevel,
        "course_rating": courseRating.toJson(),
        "total_reviews": totalReviews,
    };
}

class CourseRating {
    dynamic ratingCount;
    dynamic ratingSum;
    dynamic ratingAvg;
    Map<String, dynamic> countByValue;

    CourseRating({
        required this.ratingCount,
        required this.ratingSum,
        required this.ratingAvg,
        required this.countByValue,
    });

    factory CourseRating.fromJson(Map<String, dynamic> json) => CourseRating(
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

class TotalDuration {
    String hours;
    String minutes;

    TotalDuration({
        required this.hours,
        required this.minutes,
    });

    factory TotalDuration.fromJson(Map<String, dynamic> json) => TotalDuration(
        hours: json["hours"],
        minutes: json["minutes"],
    );

    Map<String, dynamic> toJson() => {
        "hours": hours,
        "minutes": minutes,
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

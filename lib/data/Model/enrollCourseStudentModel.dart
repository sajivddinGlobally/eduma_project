// To parse this JSON data, do
//
//     final enrolleCourseStudentModel = enrolleCourseStudentModelFromJson(jsonString);

import 'dart:convert';

EnrolleCourseStudentModel enrolleCourseStudentModelFromJson(String str) => EnrolleCourseStudentModel.fromJson(json.decode(str));

String enrolleCourseStudentModelToJson(EnrolleCourseStudentModel data) => json.encode(data.toJson());

class EnrolleCourseStudentModel {
    String status;
    Data data;

    EnrolleCourseStudentModel({
        required this.status,
        required this.data,
    });

    factory EnrolleCourseStudentModel.fromJson(Map<String, dynamic> json) => EnrolleCourseStudentModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
    };
}

class Data {
    int studentId;
    List<Course> courses;
    Summary summary;
    Pagination pagination;

    Data({
        required this.studentId,
        required this.courses,
        required this.summary,
        required this.pagination,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        studentId: json["student_id"],
        courses: List<Course>.from(json["courses"].map((x) => Course.fromJson(x))),
        summary: Summary.fromJson(json["summary"]),
        pagination: Pagination.fromJson(json["pagination"]),
    );

    Map<String, dynamic> toJson() => {
        "student_id": studentId,
        "courses": List<dynamic>.from(courses.map((x) => x.toJson())),
        "summary": summary.toJson(),
        "pagination": pagination.toJson(),
    };
}

class Course {
    String enrollmentId;
    String courseId;
    String title;
    String description;
    String excerpt;
    String thumbnail;
    String permalink;
    Instructor instructor;
    Pricing pricing;
    CourseInfo courseInfo;
    EnrollmentInfo enrollmentInfo;
    ProgressDetails progressDetails;
    RatingInfo ratingInfo;
    Navigation navigation;

    Course({
        required this.enrollmentId,
        required this.courseId,
        required this.title,
        required this.description,
        required this.excerpt,
        required this.thumbnail,
        required this.permalink,
        required this.instructor,
        required this.pricing,
        required this.courseInfo,
        required this.enrollmentInfo,
        required this.progressDetails,
        required this.ratingInfo,
        required this.navigation,
    });

    factory Course.fromJson(Map<String, dynamic> json) => Course(
        enrollmentId: json["enrollment_id"],
        courseId: json["course_id"],
        title: json["title"],
        description: json["description"],
        excerpt: json["excerpt"],
        thumbnail: json["thumbnail"],
        permalink: json["permalink"],
        instructor: Instructor.fromJson(json["instructor"]),
        pricing: Pricing.fromJson(json["pricing"]),
        courseInfo: CourseInfo.fromJson(json["course_info"]),
        enrollmentInfo: EnrollmentInfo.fromJson(json["enrollment_info"]),
        progressDetails: ProgressDetails.fromJson(json["progress_details"]),
        ratingInfo: RatingInfo.fromJson(json["rating_info"]),
        navigation: Navigation.fromJson(json["navigation"]),
    );

    Map<String, dynamic> toJson() => {
        "enrollment_id": enrollmentId,
        "course_id": courseId,
        "title": title,
        "description": description,
        "excerpt": excerpt,
        "thumbnail": thumbnail,
        "permalink": permalink,
        "instructor": instructor.toJson(),
        "pricing": pricing.toJson(),
        "course_info": courseInfo.toJson(),
        "enrollment_info": enrollmentInfo.toJson(),
        "progress_details": progressDetails.toJson(),
        "rating_info": ratingInfo.toJson(),
        "navigation": navigation.toJson(),
    };
}

class CourseInfo {
    String level;
    String duration;
    List<Category> categories;
    int totalLessons;
    int totalQuizzes;

    CourseInfo({
        required this.level,
        required this.duration,
        required this.categories,
        required this.totalLessons,
        required this.totalQuizzes,
    });

    factory CourseInfo.fromJson(Map<String, dynamic> json) => CourseInfo(
        level: json["level"],
        duration: json["duration"],
        categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
        totalLessons: json["total_lessons"],
        totalQuizzes: json["total_quizzes"],
    );

    Map<String, dynamic> toJson() => {
        "level": level,
        "duration": duration,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "total_lessons": totalLessons,
        "total_quizzes": totalQuizzes,
    };
}

class Category {
    int id;
    String name;
    String slug;

    Category({
        required this.id,
        required this.name,
        required this.slug,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
    };
}

class EnrollmentInfo {
    DateTime enrollmentDate;
    bool isCompleted;
    dynamic completionDate;
    int progressPercentage;

    EnrollmentInfo({
        required this.enrollmentDate,
        required this.isCompleted,
        required this.completionDate,
        required this.progressPercentage,
    });

    factory EnrollmentInfo.fromJson(Map<String, dynamic> json) => EnrollmentInfo(
        enrollmentDate: DateTime.parse(json["enrollment_date"]),
        isCompleted: json["is_completed"],
        completionDate: json["completion_date"],
        progressPercentage: json["progress_percentage"],
    );

    Map<String, dynamic> toJson() => {
        "enrollment_date": enrollmentDate.toIso8601String(),
        "is_completed": isCompleted,
        "completion_date": completionDate,
        "progress_percentage": progressPercentage,
    };
}

class Instructor {
    int id;
    String name;
    String email;
    String avatar;

    Instructor({
        required this.id,
        required this.name,
        required this.email,
        required this.avatar,
    });

    factory Instructor.fromJson(Map<String, dynamic> json) => Instructor(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        avatar: json["avatar"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "avatar": avatar,
    };
}

class Navigation {
    dynamic lastLesson;
    dynamic nextLesson;
    String continueUrl;

    Navigation({
        required this.lastLesson,
        required this.nextLesson,
        required this.continueUrl,
    });

    factory Navigation.fromJson(Map<String, dynamic> json) => Navigation(
        lastLesson: json["last_lesson"],
        nextLesson: json["next_lesson"],
        continueUrl: json["continue_url"],
    );

    Map<String, dynamic> toJson() => {
        "last_lesson": lastLesson,
        "next_lesson": nextLesson,
        "continue_url": continueUrl,
    };
}

class Pricing {
    bool isFree;
    String price;
    String salePrice;
    String currency;

    Pricing({
        required this.isFree,
        required this.price,
        required this.salePrice,
        required this.currency,
    });

    factory Pricing.fromJson(Map<String, dynamic> json) => Pricing(
        isFree: json["is_free"],
        price: json["price"],
        salePrice: json["sale_price"],
        currency: json["currency"],
    );

    Map<String, dynamic> toJson() => {
        "is_free": isFree,
        "price": price,
        "sale_price": salePrice,
        "currency": currency,
    };
}

class ProgressDetails {
    int completedLessons;
    int totalLessons;
    int completedQuizzes;
    int totalQuizzes;
    int overallProgress;

    ProgressDetails({
        required this.completedLessons,
        required this.totalLessons,
        required this.completedQuizzes,
        required this.totalQuizzes,
        required this.overallProgress,
    });

    factory ProgressDetails.fromJson(Map<String, dynamic> json) => ProgressDetails(
        completedLessons: json["completed_lessons"],
        totalLessons: json["total_lessons"],
        completedQuizzes: json["completed_quizzes"],
        totalQuizzes: json["total_quizzes"],
        overallProgress: json["overall_progress"],
    );

    Map<String, dynamic> toJson() => {
        "completed_lessons": completedLessons,
        "total_lessons": totalLessons,
        "completed_quizzes": completedQuizzes,
        "total_quizzes": totalQuizzes,
        "overall_progress": overallProgress,
    };
}

class RatingInfo {
    int courseAverageRating;
    int courseTotalRatings;
    dynamic userRating;

    RatingInfo({
        required this.courseAverageRating,
        required this.courseTotalRatings,
        required this.userRating,
    });

    factory RatingInfo.fromJson(Map<String, dynamic> json) => RatingInfo(
        courseAverageRating: json["course_average_rating"],
        courseTotalRatings: json["course_total_ratings"],
        userRating: json["user_rating"],
    );

    Map<String, dynamic> toJson() => {
        "course_average_rating": courseAverageRating,
        "course_total_ratings": courseTotalRatings,
        "user_rating": userRating,
    };
}

class Pagination {
    int currentPage;
    int perPage;
    int totalItems;
    int totalPages;

    Pagination({
        required this.currentPage,
        required this.perPage,
        required this.totalItems,
        required this.totalPages,
    });

    factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        currentPage: json["current_page"],
        perPage: json["per_page"],
        totalItems: json["total_items"],
        totalPages: json["total_pages"],
    );

    Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "per_page": perPage,
        "total_items": totalItems,
        "total_pages": totalPages,
    };
}

class Summary {
    int totalEnrolled;
    int totalCompleted;
    int totalActive;
    int completionRate;

    Summary({
        required this.totalEnrolled,
        required this.totalCompleted,
        required this.totalActive,
        required this.completionRate,
    });

    factory Summary.fromJson(Map<String, dynamic> json) => Summary(
        totalEnrolled: json["total_enrolled"],
        totalCompleted: json["total_completed"],
        totalActive: json["total_active"],
        completionRate: json["completion_rate"],
    );

    Map<String, dynamic> toJson() => {
        "total_enrolled": totalEnrolled,
        "total_completed": totalCompleted,
        "total_active": totalActive,
        "completion_rate": completionRate,
    };
}

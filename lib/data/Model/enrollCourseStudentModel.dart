// import 'dart:convert';

// EnrolleCourseStudentModel enrolleCourseStudentModelFromJson(String str) =>
//     EnrolleCourseStudentModel.fromJson(json.decode(str));

// String enrolleCourseStudentModelToJson(EnrolleCourseStudentModel data) =>
//     json.encode(data.toJson());

// class EnrolleCourseStudentModel {
//   bool success;
//   int totalCourses;
//   List<Course> courses;

//   EnrolleCourseStudentModel({
//     required this.success,
//     required this.totalCourses,
//     required this.courses,
//   });

//   factory EnrolleCourseStudentModel.fromJson(Map<String, dynamic> json) =>
//       EnrolleCourseStudentModel(
//         success: json["success"],
//         totalCourses: json["total_courses"],
//         courses: List<Course>.from(
//           json["courses"].map((x) => Course.fromJson(x)),
//         ),
//       );

//   Map<String, dynamic> toJson() => {
//     "success": success,
//     "total_courses": totalCourses,
//     "courses": List<dynamic>.from(courses.map((x) => x.toJson())),
//   };
// }

// class Course {
//   int id;
//   String title;
//   String url;
//   String? thumbnail;
//   String description;
//   String content;
//   String price;
//   String regularPrice;
//   String salePrice;
//   int finalPrice;
//   bool isFree;
//   String courseType;
//   String currency;
//   String level;
//   Duration duration;
//   String materialIncludes;
//   DateTime enrollmentDate;
//   int progress;
//   Instructor instructor;
//   List<Curriculum> curriculum;
//   int totalTopics;
//   int totalLessons;

//   Course({
//     required this.id,
//     required this.title,
//     required this.url,
//     this.thumbnail,
//     required this.description,
//     required this.content,
//     required this.price,
//     required this.regularPrice,
//     required this.salePrice,
//     required this.finalPrice,
//     required this.isFree,
//     required this.courseType,
//     required this.currency,
//     required this.level,
//     required this.duration,
//     required this.materialIncludes,
//     required this.enrollmentDate,
//     required this.progress,
//     required this.instructor,
//     required this.curriculum,
//     required this.totalTopics,
//     required this.totalLessons,
//   });

//   factory Course.fromJson(Map<String, dynamic> json) => Course(
//     id: json["id"],
//     title: json["title"],
//     url: json["url"],
//     //thumbnail: json["thumbnail"],
//     thumbnail: json["thumbnail"] is String ? json["thumbnail"] : null, // ✅
//     description: json["description"],
//     content: json["content"],
//     price: json["price"],
//     regularPrice: json["regular_price"],
//     salePrice: json["sale_price"],
//     finalPrice: json["final_price"],
//     isFree: json["is_free"],
//     courseType: json["course_type"],
//     currency: json["currency"],
//     level: json["level"],
//     duration: Duration.fromJson(json["duration"]),
//     materialIncludes: json["material_includes"],
//     enrollmentDate: DateTime.parse(json["enrollment_date"]),
//     progress: json["progress"],
//     instructor: Instructor.fromJson(json["instructor"]),
//     curriculum: List<Curriculum>.from(
//       json["curriculum"].map((x) => Curriculum.fromJson(x)),
//     ),
//     totalTopics: json["total_topics"],
//     totalLessons: json["total_lessons"],
//   );

//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "title": title,
//     "url": url,
//     //"thumbnail": thumbnail,
//     "thumbnail": thumbnail ?? "", // safe default
//     "description": description,
//     "content": content,
//     "price": price,
//     "regular_price": regularPrice,
//     "sale_price": salePrice,
//     "final_price": finalPrice,
//     "is_free": isFree,
//     "course_type": courseType,
//     "currency": currency,
//     "level": level,
//     "duration": duration.toJson(),
//     "material_includes": materialIncludes,
//     "enrollment_date": enrollmentDate.toIso8601String(),
//     "progress": progress,
//     "instructor": instructor.toJson(),
//     "curriculum": List<dynamic>.from(curriculum.map((x) => x.toJson())),
//     "total_topics": totalTopics,
//     "total_lessons": totalLessons,
//   };
// }

// class Curriculum {
//   int id;
//   String title;
//   String description;
//   List<Lesson> lessons;

//   Curriculum({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.lessons,
//   });

//   factory Curriculum.fromJson(Map<String, dynamic> json) => Curriculum(
//     id: json["id"],
//     title: json["title"],
//     description: json["description"],
//     lessons: List<Lesson>.from(json["lessons"].map((x) => Lesson.fromJson(x))),
//   );

//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "title": title,
//     "description": description,
//     "lessons": List<dynamic>.from(lessons.map((x) => x.toJson())),
//   };
// }

// class Lesson {
//   int id;
//   String title;
//   String content;
//   String excerpt;
//   Video video;
//   List<dynamic> attachments;
//   String duration;

//   Lesson({
//     required this.id,
//     required this.title,
//     required this.content,
//     required this.excerpt,
//     required this.video,
//     required this.attachments,
//     required this.duration,
//   });

//   factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
//     id: json["id"],
//     title: json["title"],
//     content: json["content"],
//     excerpt: json["excerpt"],
//     video: Video.fromJson(json["video"]),
//     attachments: List<dynamic>.from(json["attachments"].map((x) => x)),
//     duration: json["duration"],
//   );

//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "title": title,
//     "content": content,
//     "excerpt": excerpt,
//     "video": video.toJson(),
//     "attachments": List<dynamic>.from(attachments.map((x) => x)),
//     "duration": duration,
//   };
// }

// class Video {
//   Source source;
//   String url;
//   Runtime runtime;

//   Video({required this.source, required this.url, required this.runtime});

//   factory Video.fromJson(Map<String, dynamic> json) => Video(
//     source: sourceValues.map[json["source"]]!,
//     url: json["url"],
//     runtime: Runtime.fromJson(json["runtime"]),
//   );

//   Map<String, dynamic> toJson() => {
//     "source": sourceValues.reverse[source],
//     "url": url,
//     "runtime": runtime.toJson(),
//   };
// }

// class Runtime {
//   String hours;
//   String minutes;
//   String seconds;

//   Runtime({required this.hours, required this.minutes, required this.seconds});

//   factory Runtime.fromJson(Map<String, dynamic> json) => Runtime(
//     hours: json["hours"],
//     minutes: json["minutes"],
//     seconds: json["seconds"],
//   );

//   Map<String, dynamic> toJson() => {
//     "hours": hours,
//     "minutes": minutes,
//     "seconds": seconds,
//   };
// }

// enum Source { EXTERNAL_URL }

// final sourceValues = EnumValues({"external_url": Source.EXTERNAL_URL});

// class Duration {
//   String hours;
//   String minutes;

//   Duration({required this.hours, required this.minutes});

//   factory Duration.fromJson(Map<String, dynamic> json) =>
//       Duration(hours: json["hours"], minutes: json["minutes"]);

//   Map<String, dynamic> toJson() => {"hours": hours, "minutes": minutes};
// }

// class Instructor {
//   String id;
//   String name;
//   String email;
//   String bio;
//   String avatar;

//   Instructor({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.bio,
//     required this.avatar,
//   });

//   factory Instructor.fromJson(Map<String, dynamic> json) => Instructor(
//     id: json["id"],
//     name: json["name"],
//     email: json["email"],
//     bio: json["bio"],
//     avatar: json["avatar"],
//   );

//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "email": email,
//     "bio": bio,
//     "avatar": avatar,
//   };
// }

// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }


import 'dart:convert';

EnrolleCourseStudentModel enrolleCourseStudentModelFromJson(String str) =>
    EnrolleCourseStudentModel.fromJson(json.decode(str));

String enrolleCourseStudentModelToJson(EnrolleCourseStudentModel data) =>
    json.encode(data.toJson());

class EnrolleCourseStudentModel {
  bool success;
  int totalCourses;
  List<Course> courses;

  EnrolleCourseStudentModel({
    required this.success,
    required this.totalCourses,
    required this.courses,
  });

  factory EnrolleCourseStudentModel.fromJson(Map<String, dynamic> json) =>
      EnrolleCourseStudentModel(
        success: json["success"] ?? false,
        totalCourses: json["total_courses"] ?? 0,
        courses: json["courses"] is List
            ? List<Course>.from(json["courses"].map((x) => Course.fromJson(x)))
            : [],
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
  String url;
  String? thumbnail;
  String description;
  String content;
  String price;
  String regularPrice;
  String salePrice;
  int finalPrice;
  bool isFree;
  String courseType;
  String currency;
  String level;
  CourseDuration duration;
  String materialIncludes;
  DateTime enrollmentDate;
  int progress;
  Instructor instructor;
  List<Curriculum> curriculum;
  int totalTopics;
  int totalLessons;

  Course({
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnail,
    required this.description,
    required this.content,
    required this.price,
    required this.regularPrice,
    required this.salePrice,
    required this.finalPrice,
    required this.isFree,
    required this.courseType,
    required this.currency,
    required this.level,
    required this.duration,
    required this.materialIncludes,
    required this.enrollmentDate,
    required this.progress,
    required this.instructor,
    required this.curriculum,
    required this.totalTopics,
    required this.totalLessons,
  });

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json["id"] ?? 0,
        title: json["title"] ?? "",
        url: json["url"] ?? "",
        thumbnail: json["thumbnail"] is String ? json["thumbnail"] : null,
        description: json["description"] ?? "",
        content: json["content"] ?? "",
        price: json["price"] ?? "",
        regularPrice: json["regular_price"] ?? "",
        salePrice: json["sale_price"] ?? "",
        finalPrice: json["final_price"] ?? 0,
        isFree: json["is_free"] ?? false,
        courseType: json["course_type"] ?? "",
        currency: json["currency"] ?? "",
        level: json["level"] ?? "",
        duration: json["duration"] is Map<String, dynamic>
            ? CourseDuration.fromJson(json["duration"])
            : CourseDuration(hours: "0", minutes: "0"),
        materialIncludes: json["material_includes"] ?? "",
        enrollmentDate: DateTime.tryParse(json["enrollment_date"] ?? "") ??
            DateTime.now(),
        progress: json["progress"] ?? 0,
        instructor: json["instructor"] is Map<String, dynamic>
            ? Instructor.fromJson(json["instructor"])
            : Instructor(id: "0", name: "", email: "", bio: "", avatar: ""),
        curriculum: json["curriculum"] is List
            ? List<Curriculum>.from(
                json["curriculum"].map((x) => Curriculum.fromJson(x)))
            : [],
        totalTopics: json["total_topics"] ?? 0,
        totalLessons: json["total_lessons"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
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
        "duration": duration.toJson(),
        "material_includes": materialIncludes,
        "enrollment_date": enrollmentDate.toIso8601String(),
        "progress": progress,
        "instructor": instructor.toJson(),
        "curriculum": List<dynamic>.from(curriculum.map((x) => x.toJson())),
        "total_topics": totalTopics,
        "total_lessons": totalLessons,
      };
}

class Curriculum {
  int id;
  String title;
  String description;
  List<Lesson> lessons;

  Curriculum({
    required this.id,
    required this.title,
    required this.description,
    required this.lessons,
  });

  factory Curriculum.fromJson(Map<String, dynamic> json) => Curriculum(
        id: json["id"] ?? 0,
        title: json["title"] ?? "",
        description: json["description"] ?? "",
        lessons: json["lessons"] is List
            ? List<Lesson>.from(json["lessons"].map((x) => Lesson.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "lessons": List<dynamic>.from(lessons.map((x) => x.toJson())),
      };
}

class Lesson {
  int id;
  String title;
  String content;
  String excerpt;
  Video video;
  List<dynamic> attachments;
  String duration;

  Lesson({
    required this.id,
    required this.title,
    required this.content,
    required this.excerpt,
    required this.video,
    required this.attachments,
    required this.duration,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
        id: json["id"] ?? 0,
        title: json["title"] ?? "",
        content: json["content"] ?? "",
        excerpt: json["excerpt"] ?? "",
        video: json["video"] is Map<String, dynamic>
            ? Video.fromJson(json["video"])
            : Video(
                source: Source.EXTERNAL_URL,
                url: "",
                runtime: Runtime(hours: "0", minutes: "0", seconds: "0")),
        attachments: json["attachments"] is List ? json["attachments"] : [],
        duration: json["duration"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "excerpt": excerpt,
        "video": video.toJson(),
        "attachments": List<dynamic>.from(attachments.map((x) => x)),
        "duration": duration,
      };
}

class Video {
  Source source;
  String url;
  Runtime runtime;

  Video({required this.source, required this.url, required this.runtime});

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        source: sourceValues.map[json["source"]] ?? Source.EXTERNAL_URL,
        url: json["url"] ?? "",
        runtime: json["runtime"] is Map<String, dynamic>
            ? Runtime.fromJson(json["runtime"])
            : Runtime(hours: "0", minutes: "0", seconds: "0"),
      );

  Map<String, dynamic> toJson() => {
        "source": sourceValues.reverse[source],
        "url": url,
        "runtime": runtime.toJson(),
      };
}

class Runtime {
  String hours;
  String minutes;
  String seconds;

  Runtime({required this.hours, required this.minutes, required this.seconds});

  factory Runtime.fromJson(Map<String, dynamic> json) => Runtime(
        hours: json["hours"] ?? "0",
        minutes: json["minutes"] ?? "0",
        seconds: json["seconds"] ?? "0",
      );

  Map<String, dynamic> toJson() => {
        "hours": hours,
        "minutes": minutes,
        "seconds": seconds,
      };
}

enum Source { EXTERNAL_URL }

final sourceValues = EnumValues({"external_url": Source.EXTERNAL_URL});

class CourseDuration {
  String hours;
  String minutes;

  CourseDuration({required this.hours, required this.minutes});

  factory CourseDuration.fromJson(Map<String, dynamic> json) => CourseDuration(
        hours: json["hours"] ?? "0",
        minutes: json["minutes"] ?? "0",
      );

  Map<String, dynamic> toJson() => {"hours": hours, "minutes": minutes};
}

class Instructor {
  String id;
  String name;
  String email;
  String bio;
  String avatar;

  Instructor({
    required this.id,
    required this.name,
    required this.email,
    required this.bio,
    required this.avatar,
  });

  factory Instructor.fromJson(Map<String, dynamic> json) => Instructor(
        id: json["id"]?.toString() ?? "0",
        name: json["name"] ?? "",
        email: json["email"] ?? "",
        bio: json["bio"] ?? "",
        avatar: json["avatar"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "bio": bio,
        "avatar": avatar,
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

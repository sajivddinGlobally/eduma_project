// To parse this JSON data, do
//
//     final popularCourseModel = popularCourseModelFromJson(jsonString);

import 'dart:convert';

List<PopularCourseModel> popularCourseModelFromJson(String str) =>
    List<PopularCourseModel>.from(
      json.decode(str).map((x) => PopularCourseModel.fromJson(x)),
    );

String popularCourseModelToJson(List<PopularCourseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PopularCourseModel {
  int id;
  String title;
  String excerpt;
  String thumbnail;
  String permalink;
  String price;
  dynamic enrollCount;
  Rating rating;
  dynamic popularityScore;
  Author author;

  PopularCourseModel({
    required this.id,
    required this.title,
    required this.excerpt,
    required this.thumbnail,
    required this.permalink,
    required this.price,
    required this.enrollCount,
    required this.rating,
    required this.popularityScore,
    required this.author,
  });

  factory PopularCourseModel.fromJson(Map<String, dynamic> json) =>
      PopularCourseModel(
        id: json["id"],
        title: json["title"] ?? '',
        excerpt: json["excerpt"] ?? '',
        //thumbnail: json["thumbnail"] ?? '',
        thumbnail: json["thumbnail"]?.toString() ?? '',
        permalink: json["permalink"] ?? '',
        price: json["price"] ?? '',
        enrollCount: json["enroll_count"],
        rating: json["rating"] != null
            ? Rating.fromJson(json["rating"])
            : Rating(
                ratingCount: 0,
                ratingSum: 0,
                ratingAvg: 0,
                countByValue: {},
              ),
        popularityScore: json["popularity_score"],
        author: json["author"] != null
            ? Author.fromJson(json["author"])
            : Author(id: 0, name: Name.ANIL_KUMAR_SINGH, avatarUrl: ''),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "excerpt": excerpt,
    "thumbnail": thumbnail,
    "permalink": permalink,
    "price": price,
    "enroll_count": enrollCount,
    "rating": rating.toJson(),
    "popularity_score": popularityScore,
    "author": author.toJson(),
  };
}

class Author {
  int id;
  Name name;
  String avatarUrl;

  Author({required this.id, required this.name, required this.avatarUrl});

  // factory Author.fromJson(Map<String, dynamic> json) => Author(
  //   id: json["id"],
  //   name: nameValues.map[json["name"]]!,
  //   avatarUrl: json["avatar_url"],
  // );
  factory Author.fromJson(Map<String, dynamic> json) => Author(
    id: json["id"] ?? 0,
    name: nameValues.map[json["name"]] ?? Name.ANIL_KUMAR_SINGH,
    avatarUrl: json["avatar_url"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": nameValues.reverse[name],
    "avatar_url": avatarUrl,
  };
}

enum Name { ANIL_KUMAR_SINGH }

final nameValues = EnumValues({"Anil Kumar Singh": Name.ANIL_KUMAR_SINGH});

class Rating {
  dynamic ratingCount;
  dynamic ratingSum;
  dynamic ratingAvg;
  Map<String, dynamic> countByValue;

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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}





// import 'dart:convert';

// List<PopularCourseModel> popularCourseModelFromJson(String str) {
//   try {
//     final jsonData = json.decode(str);
//     print('JSON Data: $jsonData'); // Debug JSON
//     return List<PopularCourseModel>.from(
//       jsonData.map((x) => PopularCourseModel.fromJson(x)),
//     );
//   } catch (e) {
//     print('JSON Parsing Error: $e');
//     return [];
//   }
// }

// String popularCourseModelToJson(List<PopularCourseModel> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class PopularCourseModel {
//   int id;
//   String title;
//   String excerpt;
//   String thumbnail;
//   String permalink;
//   String price;
//   int enrollCount;
//   Rating rating;
//   double popularityScore;
//   Author author;

//   PopularCourseModel({
//     required this.id,
//     required this.title,
//     required this.excerpt,
//     required this.thumbnail,
//     required this.permalink,
//     required this.price,
//     required this.enrollCount,
//     required this.rating,
//     required this.popularityScore,
//     required this.author,
//   });

//   factory PopularCourseModel.fromJson(Map<String, dynamic> json) => PopularCourseModel(
//         id: json["id"] is String ? int.tryParse(json["id"]) ?? 0 : (json["id"] ?? 0),
//         title: json["title"]?.toString() ?? '',
//         excerpt: json["excerpt"]?.toString() ?? '',
//         thumbnail: json["thumbnail"]?.toString() ?? '',
//         permalink: json["permalink"]?.toString() ?? '',
//         price: json["price"]?.toString() ?? '',
//         enrollCount: json["enroll_count"] is String
//             ? int.tryParse(json["enroll_count"]) ?? 0
//             : (json["enroll_count"] ?? 0),
//         rating: json["rating"] != null
//             ? Rating.fromJson(json["rating"])
//             : Rating(
//                 ratingCount: 0,
//                 ratingSum: 0,
//                 ratingAvg: 0.0,
//                 countByValue: {},
//               ),
//         popularityScore: json["popularity_score"] is String
//             ? double.tryParse(json["popularity_score"]) ?? 0.0
//             : (json["popularity_score"]?.toDouble() ?? 0.0),
//         author: json["author"] != null
//             ? Author.fromJson(json["author"])
//             : Author(
//                 id: 0,
//                 name: Name.ANIL_KUMAR_SINGH,
//                 avatarUrl: '',
//               ),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "title": title,
//         "excerpt": excerpt,
//         "thumbnail": thumbnail,
//         "permalink": permalink,
//         "price": price,
//         "enroll_count": enrollCount,
//         "rating": rating.toJson(),
//         "popularity_score": popularityScore,
//         "author": author.toJson(),
//       };
// }

// class Author {
//   int id;
//   Name name;
//   String avatarUrl;

//   Author({
//     required this.id,
//     required this.name,
//     required this.avatarUrl,
//   });

//   factory Author.fromJson(Map<String, dynamic> json) => Author(
//         id: json["id"] is String ? int.tryParse(json["id"]) ?? 0 : (json["id"] ?? 0),
//         name: nameValues.map[json["name"]?.toString()] ?? Name.ANIL_KUMAR_SINGH,
//         avatarUrl: json["avatar_url"]?.toString() ?? '',
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": nameValues.reverse[name],
//         "avatar_url": avatarUrl,
//       };
// }

// enum Name { ANIL_KUMAR_SINGH }

// final nameValues = EnumValues({"Anil Kumar Singh": Name.ANIL_KUMAR_SINGH});

// class Rating {
//   int ratingCount;
//   int ratingSum;
//   double ratingAvg;
//   Map<String, dynamic> countByValue;

//   Rating({
//     required this.ratingCount,
//     required this.ratingSum,
//     required this.ratingAvg,
//     required this.countByValue,
//   });

//   factory Rating.fromJson(Map<String, dynamic> json) => Rating(
//         ratingCount: json["rating_count"] is String
//             ? int.tryParse(json["rating_count"]) ?? 0
//             : (json["rating_count"] ?? 0),
//         ratingSum: json["rating_sum"] is String
//             ? int.tryParse(json["rating_sum"]) ?? 0
//             : (json["rating_sum"] ?? 0),
//         ratingAvg: json["rating_avg"] is String
//             ? double.tryParse(json["rating_avg"]) ?? 0.0
//             : (json["rating_avg"]?.toDouble() ?? 0.0),
//         countByValue: (json["count_by_value"] as Map?)?.map((k, v) => MapEntry(k.toString(), v)) ?? {},
//       );

//   Map<String, dynamic> toJson() => {
//         "rating_count": ratingCount,
//         "rating_sum": ratingSum,
//         "rating_avg": ratingAvg,
//         "count_by_value": Map.from(countByValue).map((k, v) => MapEntry<String, dynamic>(k, v)),
//       };
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
class PopularCourseDetailsModel {
  final int id;
  final String title;
  final String excerpt;
  final String description;
  final String thumbnail;
  final String permalink;
  final String price;
  final int enrollCount;
  final Rating rating;
  final dynamic popularityScore;
  final Author author;
  final Map<String, List<String>> meta;
  final List<Topic> topics;

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
        id: int.tryParse(json["id"].toString()) ?? 0,
        title: json["title"]?.toString() ?? "",
        excerpt: json["excerpt"]?.toString() ?? "",
        description: json["description"]?.toString() ?? "",
        thumbnail: json["thumbnail"]?.toString() ?? "",
        permalink: json["permalink"]?.toString() ?? "",
        price: json["price"]?.toString() ?? "",
        enrollCount: int.tryParse(json["enroll_count"].toString()) ?? 0,
        rating: Rating.fromJson(json["rating"] ?? {}),
        popularityScore: json["popularity_score"],
        author: Author.fromJson(json["author"] ?? {}),
        meta: (json["meta"] as Map? ?? {}).map(
          (k, v) => MapEntry(
            k.toString(),
            List<String>.from((v as List? ?? []).map((x) => x.toString())),
          ),
        ),
        topics: List<Topic>.from(
          (json["topics"] as List? ?? []).map((x) => Topic.fromJson(x)),
        ),
      );
}

class Rating {
  final int ratingCount;
  final int ratingSum;
  final int ratingAvg;

  Rating({
    required this.ratingCount,
    required this.ratingSum,
    required this.ratingAvg,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
    ratingCount: int.tryParse(json["rating_count"].toString()) ?? 0,
    ratingSum: int.tryParse(json["rating_sum"].toString()) ?? 0,
    ratingAvg: int.tryParse(json["rating_avg"].toString()) ?? 0,
  );
}

class Author {
  final String id;
  final String name;
  final String profileUrl;

  Author({required this.id, required this.name, required this.profileUrl});

  factory Author.fromJson(Map<String, dynamic> json) => Author(
    id: json["id"]?.toString() ?? "",
    name: json["name"]?.toString() ?? "",
    profileUrl: json["profile_url"]?.toString() ?? "",
  );
}

class Topic {
  final String id;
  final String name;
  final String slug;

  Topic({required this.id, required this.name, required this.slug});

  factory Topic.fromJson(Map<String, dynamic> json) => Topic(
    id: json["id"]?.toString() ?? "",
    name: json["name"]?.toString() ?? "",
    slug: json["slug"]?.toString() ?? "",
  );
}

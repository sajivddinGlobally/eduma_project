// To parse this JSON data, do
//
//     final popularCourseDetailsModel = popularCourseDetailsModelFromJson(jsonString);

import 'dart:convert';

PopularCourseDetailsModel popularCourseDetailsModelFromJson(String str) => PopularCourseDetailsModel.fromJson(json.decode(str));

String popularCourseDetailsModelToJson(PopularCourseDetailsModel data) => json.encode(data.toJson());

class PopularCourseDetailsModel {
    bool success;
    Data data;

    PopularCourseDetailsModel({
        required this.success,
        required this.data,
    });

    factory PopularCourseDetailsModel.fromJson(Map<String, dynamic> json) => PopularCourseDetailsModel(
        success: json["success"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
    };
}

class Data {
    int id;
    String title;
    String excerpt;
    String description;
    Images images;
    Pricing pricing;
    dynamic enrollCount;
    Rating rating;
    List<Category> categories;
    List<dynamic> tags;
    List<dynamic> features;
    List<dynamic> requirements;
    List<dynamic> outcomes;
    List<Topic> topics;
    List<dynamic> reviews;
    Author author;

    Data({
        required this.id,
        required this.title,
        required this.excerpt,
        required this.description,
        required this.images,
        required this.pricing,
        required this.enrollCount,
        required this.rating,
        required this.categories,
        required this.tags,
        required this.features,
        required this.requirements,
        required this.outcomes,
        required this.topics,
        required this.reviews,
        required this.author,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        title: json["title"],
        excerpt: json["excerpt"],
        description: json["description"],
        images: Images.fromJson(json["images"]),
        pricing: Pricing.fromJson(json["pricing"]),
        enrollCount: json["enroll_count"],
        rating: Rating.fromJson(json["rating"]),
        categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
        tags: List<dynamic>.from(json["tags"].map((x) => x)),
        features: List<dynamic>.from(json["features"].map((x) => x)),
        requirements: List<dynamic>.from(json["requirements"].map((x) => x)),
        outcomes: List<dynamic>.from(json["outcomes"].map((x) => x)),
        topics: List<Topic>.from(json["topics"].map((x) => Topic.fromJson(x))),
        reviews: List<dynamic>.from(json["reviews"].map((x) => x)),
        author: Author.fromJson(json["author"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "excerpt": excerpt,
        "description": description,
        "images": images.toJson(),
        "pricing": pricing.toJson(),
        "enroll_count": enrollCount,
        "rating": rating.toJson(),
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "features": List<dynamic>.from(features.map((x) => x)),
        "requirements": List<dynamic>.from(requirements.map((x) => x)),
        "outcomes": List<dynamic>.from(outcomes.map((x) => x)),
        "topics": List<dynamic>.from(topics.map((x) => x.toJson())),
        "reviews": List<dynamic>.from(reviews.map((x) => x)),
        "author": author.toJson(),
    };
}

class Author {
    int id;
    String name;
    String avatarUrl;
    String bio;
    SocialLinks socialLinks;

    Author({
        required this.id,
        required this.name,
        required this.avatarUrl,
        required this.bio,
        required this.socialLinks,
    });

    factory Author.fromJson(Map<String, dynamic> json) => Author(
        id: json["id"],
        name: json["name"],
        avatarUrl: json["avatar_url"],
        bio: json["bio"],
        socialLinks: SocialLinks.fromJson(json["social_links"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "avatar_url": avatarUrl,
        "bio": bio,
        "social_links": socialLinks.toJson(),
    };
}

class SocialLinks {
    String website;
    String facebook;
    String twitter;
    String linkedin;

    SocialLinks({
        required this.website,
        required this.facebook,
        required this.twitter,
        required this.linkedin,
    });

    factory SocialLinks.fromJson(Map<String, dynamic> json) => SocialLinks(
        website: json["website"],
        facebook: json["facebook"],
        twitter: json["twitter"],
        linkedin: json["linkedin"],
    );

    Map<String, dynamic> toJson() => {
        "website": website,
        "facebook": facebook,
        "twitter": twitter,
        "linkedin": linkedin,
    };
}

class Category {
    int id;
    String name;
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

class Images {
    String thumbnail;
    String large;
    String full;
    String gallery;

    Images({
        required this.thumbnail,
        required this.large,
        required this.full,
        required this.gallery,
    });

    factory Images.fromJson(Map<String, dynamic> json) => Images(
        thumbnail: json["thumbnail"],
        large: json["large"],
        full: json["full"],
        gallery: json["gallery"],
    );

    Map<String, dynamic> toJson() => {
        "thumbnail": thumbnail,
        "large": large,
        "full": full,
        "gallery": gallery,
    };
}

class Pricing {
    String price;
    String salePrice;
    bool isFree;
    String priceLabel;
    int discountPercentage;

    Pricing({
        required this.price,
        required this.salePrice,
        required this.isFree,
        required this.priceLabel,
        required this.discountPercentage,
    });

    factory Pricing.fromJson(Map<String, dynamic> json) => Pricing(
        price: json["price"],
        salePrice: json["sale_price"],
        isFree: json["is_free"],
        priceLabel: json["price_label"],
        discountPercentage: json["discount_percentage"],
    );

    Map<String, dynamic> toJson() => {
        "price": price,
        "sale_price": salePrice,
        "is_free": isFree,
        "price_label": priceLabel,
        "discount_percentage": discountPercentage,
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
    String? id;
    String? title;
    String? summary;
    List<dynamic> lessons;
    List<dynamic> quizzes;

    Topic({
        required this.id,
        required this.title,
        required this.summary,
        required this.lessons,
        required this.quizzes,
    });

    factory Topic.fromJson(Map<String, dynamic> json) => Topic(
        id: json["id"],
        title: json["title"],
        summary: json["summary"],
        lessons: List<dynamic>.from(json["lessons"].map((x) => x)),
        quizzes: List<dynamic>.from(json["quizzes"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "summary": summary,
        "lessons": List<dynamic>.from(lessons.map((x) => x)),
        "quizzes": List<dynamic>.from(quizzes.map((x) => x)),
    };
}

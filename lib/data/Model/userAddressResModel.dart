// // To parse this JSON data, do
// //
// //     final userAddressResModel = userAddressResModelFromJson(jsonString);

// import 'dart:convert';

// UserAddressResModel userAddressResModelFromJson(String str) => UserAddressResModel.fromJson(json.decode(str));

// String userAddressResModelToJson(UserAddressResModel data) => json.encode(data.toJson());

// class UserAddressResModel {
//     Ing billing;
//     Ing shipping;
//     bool hasBilling;
//     bool hasShipping;

//     UserAddressResModel({
//         required this.billing,
//         required this.shipping,
//         required this.hasBilling,
//         required this.hasShipping,
//     });

//     factory UserAddressResModel.fromJson(Map<String, dynamic> json) => UserAddressResModel(
//         billing: Ing.fromJson(json["billing"]),
//         shipping: Ing.fromJson(json["shipping"]),
//         hasBilling: json["has_billing"],
//         hasShipping: json["has_shipping"],
//     );

//     Map<String, dynamic> toJson() => {
//         "billing": billing.toJson(),
//         "shipping": shipping.toJson(),
//         "has_billing": hasBilling,
//         "has_shipping": hasShipping,
//     };
// }

// class Ing {
//     String firstName;
//     String lastName;
//     String address1;
//     String city;
//     String state;
//     String postcode;
//     String country;
//     String? phone;
//     String? email;

//     Ing({
//         required this.firstName,
//         required this.lastName,
//         required this.address1,
//         required this.city,
//         required this.state,
//         required this.postcode,
//         required this.country,
//         this.phone,
//         this.email,
//     });

//     factory Ing.fromJson(Map<String, dynamic> json) => Ing(
//         firstName: json["first_name"],
//         lastName: json["last_name"],
//         address1: json["address_1"],
//         city: json["city"],
//         state: json["state"],
//         postcode: json["postcode"],
//         country: json["country"],
//         phone: json["phone"],
//         email: json["email"],
//     );

//     Map<String, dynamic> toJson() => {
//         "first_name": firstName,
//         "last_name": lastName,
//         "address_1": address1,
//         "city": city,
//         "state": state,
//         "postcode": postcode,
//         "country": country,
//         "phone": phone,
//         "email": email,
//     };
// }


// To parse this JSON data, do
//
//     final userAddressResModel = userAddressResModelFromJson(jsonString);

import 'dart:convert';

UserAddressResModel userAddressResModelFromJson(String str) =>
    UserAddressResModel.fromJson(json.decode(str));

String userAddressResModelToJson(UserAddressResModel data) =>
    json.encode(data.toJson());

class UserAddressResModel {
  final Ing? billing;
  final Ing? shipping;
  final bool hasBilling;
  final bool hasShipping;

  UserAddressResModel({
    this.billing,
    this.shipping,
    required this.hasBilling,
    required this.hasShipping,
  });

  factory UserAddressResModel.fromJson(Map<String, dynamic> json) {
    return UserAddressResModel(
      billing: _parseIng(json["billing"]),
      shipping: _parseIng(json["shipping"]),
      hasBilling: json["has_billing"] ?? false,
      hasShipping: json["has_shipping"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        "billing": billing?.toJson(),
        "shipping": shipping?.toJson(),
        "has_billing": hasBilling,
        "has_shipping": hasShipping,
      };

  /// Helper function to handle both List and Map formats safely
  static Ing? _parseIng(dynamic data) {
    if (data == null) return null;

    if (data is Map<String, dynamic>) {
      return Ing.fromJson(data);
    } else if (data is List && data.isNotEmpty) {
      final first = data.first;
      if (first is Map<String, dynamic>) {
        return Ing.fromJson(first);
      }
    }

    return null;
  }
}

class Ing {
  final String firstName;
  final String lastName;
  final String address1;
  final String city;
  final String state;
  final String postcode;
  final String country;
  final String? phone;
  final String? email;

  Ing({
    required this.firstName,
    required this.lastName,
    required this.address1,
    required this.city,
    required this.state,
    required this.postcode,
    required this.country,
    this.phone,
    this.email,
  });

  factory Ing.fromJson(Map<String, dynamic> json) => Ing(
        firstName: json["first_name"] ?? "",
        lastName: json["last_name"] ?? "",
        address1: json["address_1"] ?? "",
        city: json["city"] ?? "",
        state: json["state"] ?? "",
        postcode: json["postcode"] ?? "",
        country: json["country"] ?? "",
        phone: json["phone"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "address_1": address1,
        "city": city,
        "state": state,
        "postcode": postcode,
        "country": country,
        "phone": phone,
        "email": email,
      };

  /// Optional empty instance for fallback use
  factory Ing.empty() => Ing(
        firstName: "",
        lastName: "",
        address1: "",
        city: "",
        state: "",
        postcode: "",
        country: "",
      );
}


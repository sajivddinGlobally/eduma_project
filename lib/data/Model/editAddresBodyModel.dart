// To parse this JSON data, do
//
//     final editAddressBodyModel = editAddressBodyModelFromJson(jsonString);

import 'dart:convert';

EditAddressBodyModel editAddressBodyModelFromJson(String str) => EditAddressBodyModel.fromJson(json.decode(str));

String editAddressBodyModelToJson(EditAddressBodyModel data) => json.encode(data.toJson());

class EditAddressBodyModel {
    Ing billing;
    Ing shipping;

    EditAddressBodyModel({
        required this.billing,
        required this.shipping,
    });

    factory EditAddressBodyModel.fromJson(Map<String, dynamic> json) => EditAddressBodyModel(
        billing: Ing.fromJson(json["billing"]),
        shipping: Ing.fromJson(json["shipping"]),
    );

    Map<String, dynamic> toJson() => {
        "billing": billing.toJson(),
        "shipping": shipping.toJson(),
    };
}

class Ing {
    String firstName;
    String lastName;
    String address1;
    String city;
    String state;
    String postcode;
    String country;
    String? phone;
    String? email;

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
        firstName: json["first_name"],
        lastName: json["last_name"],
        address1: json["address_1"],
        city: json["city"],
        state: json["state"],
        postcode: json["postcode"],
        country: json["country"],
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
}

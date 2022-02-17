// To parse this JSON data, do
//
//     final hdDetails = hdDetailsFromJson(jsonString);

import 'dart:convert';

HdDetails hdDetailsFromJson(String str) => HdDetails.fromJson(json.decode(str));

String hdDetailsToJson(HdDetails data) => json.encode(data.toJson());

class HdDetails {
    HdDetails({
        this.data,
        this.status,
    });

    Data ?data;
    bool ?status;

    factory HdDetails.fromJson(Map<String, dynamic> json) => HdDetails(
        data: Data.fromJson(json["data"]),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "status": status,
    };
}

class Data {
    Data({
        this.id,
        this.productName,
        this.price,
        this.unit,
        this.image,
        this.shortDescription,
        this.longDescription,
    });

    int? id;
    String ?productName;
    String ?price;
    String ?unit;
    String ?image;
    String? shortDescription;
    String? longDescription;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        productName: json["product_name"],
        price: json["price"],
        unit: json["unit"],
        image: json["image"],
        shortDescription: json["short_description"],
        longDescription: json["long_description"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "product_name": productName,
        "price": price,
        "unit": unit,
        "image": image,
        "short_description": shortDescription,
        "long_description": longDescription,
    };
}

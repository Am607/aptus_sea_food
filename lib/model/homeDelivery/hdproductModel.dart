// To parse this JSON data, do
//
//     final hdproduct = hdproductFromJson(jsonString);

import 'dart:convert';

Hdproduct hdproductFromJson(String str) => Hdproduct.fromJson(json.decode(str));

String hdproductToJson(Hdproduct data) => json.encode(data.toJson());

class Hdproduct {
    Hdproduct({
        this.data,
        this.status,
    });

    List<Datum>? data;
    bool? status;

    factory Hdproduct.fromJson(Map<String, dynamic> json) => Hdproduct(
        data:json["status"] == true ? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))) : null,
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "status": status,
    };
}

class Datum {
    Datum({
        this.id,
        this.productName,
        this.price,
        this.image,
        this.shortDescription,
    });

    int?id;
    String? productName;
    String? price;
    String? image;
    String? shortDescription;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        productName: json["product_name"],
        price: json["price"],
        image: json["image"],
        shortDescription: json["short_description"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "product_name": productName,
        "price": price,
        "image": image,
        "short_description": shortDescription,
    };
}

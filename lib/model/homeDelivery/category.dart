// To parse this JSON data, do
//
//     final homedeliveryCategry = homedeliveryCategryFromJson(jsonString);

import 'dart:convert';

HomedeliveryCategry homedeliveryCategryFromJson(String str) => HomedeliveryCategry.fromJson(json.decode(str));

String homedeliveryCategryToJson(HomedeliveryCategry data) => json.encode(data.toJson());

class HomedeliveryCategry {
    HomedeliveryCategry({
        this.data,
        this.status,
    });

    List<Datum> ?data;
    bool? status;

    factory HomedeliveryCategry.fromJson(Map<String, dynamic> json) => HomedeliveryCategry(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
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
        this.categoryName,
        this.categoryImage,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    int ?id;
    String ?categoryName;
    String? categoryImage;
    String? status;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        categoryName: json["category_name"],
        categoryImage: json["category_image"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "category_name": categoryName,
        "category_image": categoryImage,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}

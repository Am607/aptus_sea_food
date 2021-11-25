// To parse this JSON data, do
//
//     final postal = postalFromJson(jsonString);

import 'dart:convert';

Postal postalFromJson(String str) => Postal.fromJson(json.decode(str));

String postalToJson(Postal data) => json.encode(data.toJson());

class Postal {
    Postal({
        this.data,
        this.message,
        this.status,
    });

    String? data;
    String? message;
    bool? status;

    factory Postal.fromJson(Map<String, dynamic> json) => Postal(
        data: json["data"],
        message: json["message"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "data": data,
        "message": message,
        "status": status,
    };
}

// To parse this JSON data, do
//
//     final plan = planFromJson(jsonString);

import 'dart:convert';

Plan planFromJson(String str) => Plan.fromJson(json.decode(str));

String planToJson(Plan data) => json.encode(data.toJson());

class Plan {
    Plan({
        this.data,
        this.timeSlotes,
        this.status,
    });

    List<Datum> ?data;
    List<Datum>? timeSlotes;
    int? status;

    factory Plan.fromJson(Map<String, dynamic> json) => Plan(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        timeSlotes: List<Datum>.from(json["time_slotes"].map((x) => Datum.fromJson(x))),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "time_slotes": List<dynamic>.from(timeSlotes!.map((x) => x.toJson())),
        "status": status,
    };
}

class Datum {
    Datum({
        this.id,
        this.planName,
        this.createdAt,
        this.updatedAt,
        this.timeSlot,
    });

    int? id;
    String? planName;
    DateTime ?createdAt;
    DateTime? updatedAt;
    String? timeSlot;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        planName: json["plan_name"] == null ? null : json["plan_name"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        timeSlot: json["time_slot"] == null ? null : json["time_slot"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "plan_name": planName == null ? null : planName,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "time_slot": timeSlot == null ? null : timeSlot,
    };
}

// import 'dart:convert';

// Dats datsFromJson(String str) => Dats.fromJson(json.decode(str));

// String datsToJson(Dats data) => json.encode(data.toJson());

// class Dats {
//     Dats({
//         required this.data,
//         required this.status,
//     });

//     List<Datum> data;
//     int status;

//     factory Dats.fromJson(Map<String, dynamic> json) => Dats(
//         data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//         status: json["status"],
//     );

//     Map<String, dynamic> toJson() => {
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//         "status": status,
//     };
// }

// class Datum {
//     Datum({
//         required this.id,
//         required this.planName,
//         this.createdAt,
//         this.updatedAt,
//     });

//     int id;
//     String planName;
//     dynamic createdAt;
//     dynamic updatedAt;

//     factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//         id: json["id"],
//         planName: json["plan_name"],
//         createdAt: json["created_at"],
//         updatedAt: json["updated_at"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "plan_name": planName,
//         "created_at": createdAt,
//         "updated_at": updatedAt,
//     };
// }

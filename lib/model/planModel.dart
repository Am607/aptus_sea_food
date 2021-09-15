import 'dart:convert';

Dats datsFromJson(String str) => Dats.fromJson(json.decode(str));

String datsToJson(Dats data) => json.encode(data.toJson());

class Dats {
    Dats({
        required this.data,
        required this.status,
    });

    List<Datum> data;
    int status;

    factory Dats.fromJson(Map<String, dynamic> json) => Dats(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "status": status,
    };
}

class Datum {
    Datum({
        required this.id,
        required this.planName,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    String planName;
    dynamic createdAt;
    dynamic updatedAt;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        planName: json["plan_name"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "plan_name": planName,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}

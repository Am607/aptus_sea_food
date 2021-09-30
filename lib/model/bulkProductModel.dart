// To parse this JSON data, do
//
//     final suplier = suplierFromJson(jsonString);

import 'dart:convert';

Suplier suplierFromJson(String str) => Suplier.fromJson(json.decode(str));

String suplierToJson(Suplier data) => json.encode(data.toJson());

class Suplier {
  Suplier({
    this.data,
    this.status,
  });

  List<Datum>? data;
  int? status;

  factory Suplier.fromJson(Map<String, dynamic> json) => Suplier(
        data: json["status"] == 200
            ? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x)))
            : null,
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
    this.unitPrice,
    this.availableQuantity,
    this.unit,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? productName;
  String? unitPrice;
  String? availableQuantity;
  String? unit;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        productName: json["product_name"],
        unitPrice: json["unit_price"],
        availableQuantity: json["available_quantity"],
        unit: json["unit"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_name": productName,
        "unit_price": unitPrice,
        "available_quantity": availableQuantity,
        "unit": unit,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

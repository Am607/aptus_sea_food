// To parse this JSON data, do
//
//     final bulkProduct = bulkProductFromJson(jsonString);

import 'dart:convert';

BulkProduct bulkProductFromJson(String str) =>
    BulkProduct.fromJson(json.decode(str));

String bulkProductToJson(BulkProduct data) => json.encode(data.toJson());

class BulkProduct {
  BulkProduct({
    this.data,
    this.status,
  });

  Data? data;
  bool? status;

  factory BulkProduct.fromJson(Map<String, dynamic> json) => BulkProduct(
        data: json["status"] == true ? Data.fromJson(json["data"]) : null,
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "status": status,
      };
}

class Data {
  Data({
    this.userId,
    this.orderId,
    this.orderAmount,
    this.modeOfDelivery,
    this.address,
    this.transactionId,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  int? userId;
  int? orderId;
  String? orderAmount;
  String? modeOfDelivery;
  String? address;
  String? transactionId;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["user_id"],
        orderId: json["order_id"],
        orderAmount: json["order_amount"],
        modeOfDelivery: json["mode_of_delivery"],
        address: json["address"],
        transactionId: json["transaction_id"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "order_id": orderId,
        "order_amount": orderAmount,
        "mode_of_delivery": modeOfDelivery,
        "address": address,
        "transaction_id": transactionId,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
      };
}

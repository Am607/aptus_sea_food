// To parse this JSON data, do
//
//     final orderDataback = orderDatabackFromJson(jsonString);

import 'dart:convert';

OrderDataback orderDatabackFromJson(String str) =>
    OrderDataback.fromJson(json.decode(str));

String orderDatabackToJson(OrderDataback data) => json.encode(data.toJson());

class OrderDataback {
  OrderDataback({
    this.data,
    this.status,
  });

  Data? data;
  bool? status;

  factory OrderDataback.fromJson(Map<String, dynamic> json) => OrderDataback(
        data: json["status"] == true ? Data.fromJson(json["data"]) : null,
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
        "status": status,
      };
}

class Data {
  Data({
    this.userId,
    this.timeSlot,
    this.orderId,
    this.orderAmount,
    this.advance,
    this.planId,
    this.paymentMethod,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  int? userId;
  String? timeSlot;
  int? orderId;
  String? orderAmount;
  String? advance;
  String? planId;
  String? paymentMethod;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["user_id"],
        timeSlot: json["time_slot"],
        orderId: json["order_id"],
        orderAmount: json["order_amount"],
        advance: json["advance"],
        planId: json["plan_id"],
        paymentMethod: json["payment_method"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "time_slot": timeSlot,
        "order_id": orderId,
        "order_amount": orderAmount,
        "advance": advance,
        "plan_id": planId,
        "payment_method": paymentMethod,
        "updated_at": updatedAt!.toIso8601String(),
        "created_at": createdAt!.toIso8601String(),
        "id": id,
      };
}

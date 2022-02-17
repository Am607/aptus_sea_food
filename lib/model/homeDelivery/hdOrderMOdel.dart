// To parse this JSON data, do
//
//     final hdOrderModel = hdOrderModelFromJson(jsonString);

import 'dart:convert';

HdOrderModel hdOrderModelFromJson(String str) => HdOrderModel.fromJson(json.decode(str));

String hdOrderModelToJson(HdOrderModel data) => json.encode(data.toJson());

class HdOrderModel {
    HdOrderModel({
        this.data,
        this.status,
    });

    Data? data;
    bool? status;

    factory HdOrderModel.fromJson(Map<String, dynamic> json) => HdOrderModel(
        data:json["status"] == true ? Data.fromJson(json["data"]) : null,
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "data":   data?.toJson(),
        "status": status,
    };
}

class Data {
    Data({
        this.userId,
        this.orderId,
        this.orderAmount,
        this.deliveryCharge,
        this.address,
        this.transactionId,
        this.dateOfDelivery,
        this.updatedAt,
        this.createdAt,
        this.id,
    });

    int ?userId;
    int? orderId;
    String? orderAmount;
    String? deliveryCharge;
    String? address;
    dynamic  transactionId;
    DateTime? dateOfDelivery;
    DateTime? updatedAt;
    DateTime? createdAt;
    int ?id;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["user_id"],
        orderId: json["order_id"],
        orderAmount: json["order_amount"],
        deliveryCharge: json["delivery_charge"],
        address: json["address"],
        transactionId: json["transaction_id"],
        dateOfDelivery: DateTime.parse(json["date_of_delivery"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "order_id": orderId,
        "order_amount": orderAmount,
        "delivery_charge": deliveryCharge,
        "address": address,
        "transaction_id": transactionId,
        "date_of_delivery": "${dateOfDelivery?.year.toString().padLeft(4, '0')}-${dateOfDelivery?.month.toString().padLeft(2, '0')}-${dateOfDelivery?.day.toString().padLeft(2, '0')}",
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
    };
}

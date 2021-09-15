// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
    Product({
        this.data,
        this.platinumProducts,
        this.status,
    });

    List<Datuma>? data;
    List<Datuma>? platinumProducts;
    int? status;

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        data: List<Datuma>.from(json["data"].map((x) => Datuma.fromJson(x))),
        platinumProducts: List<Datuma>.from(json["platinum_products"].map((x) => Datuma.fromJson(x))),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "platinum_products": List<dynamic>.from(platinumProducts!.map((x) => x.toJson())),
        "status": status,
    };
}

class Datuma {
    Datuma({
        this.id,
        this.productName,
        required this.price,
        this.quantity,
        this.planId,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    int? id;
    String? productName;
    String price;
    String? quantity;
    String? planId;
    String? status;
    DateTime ?createdAt;
    DateTime? updatedAt;

    factory Datuma.fromJson(Map<String, dynamic> json) => Datuma(
        id: json["id"],
        productName: json["product_name"],
        price: json["price"],
        quantity: json["quantity"],
        planId: json["plan_id"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "product_name": productName,
        "price": price,
        "quantity": quantity,
        "plan_id": planId,
        "status": status,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
    };
}

// To parse this JSON data, do
//
//     final card = cardFromJson(jsonString);

import 'dart:convert';

Card cardFromJson(String str) => Card.fromJson(json.decode(str));

String cardToJson(Card data) => json.encode(data.toJson());

class Card {
    Card({
        this.data,
        this.status,
    });

    Data? data;
    bool? status;

    factory Card.fromJson(Map<String, dynamic> json) => Card(
        data: Data.fromJson(json["data"]),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
        "status": status,
    };
}

class Data {
    Data({
        this.privillageCardNo,
    });

    String ?privillageCardNo;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        privillageCardNo: json["privillage_card_no"],
    );

    Map<String, dynamic> toJson() => {
        "privillage_card_no": privillageCardNo,
    };
}

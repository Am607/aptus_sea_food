// To parse this JSON data, do
//
//     final card = cardFromJson(jsonString);

import 'dart:convert';

Carda cardFromJson(String str) => Carda.fromJson(json.decode(str));

String cardToJson(Carda data) => json.encode(data.toJson());

class Carda {
    Carda({
        this.data,
        this.status,
    });

    Data? data;
    bool? status;

    factory Carda.fromJson(Map<String, dynamic> json) => Carda(
        data:  json["status"] == true ? Data.fromJson(json["data"]) : null,
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

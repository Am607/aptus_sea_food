// To parse this JSON data, do
//
//     final signup = signupFromJson(jsonString);

import 'dart:convert';

Signup signupFromJson(String str) => Signup.fromJson(json.decode(str));

String signupToJson(Signup data) => json.encode(data.toJson());

class Signup {
    Signup({
        this.token,
        this.status,
        this.data,
    });

    String? token;
    bool? status;
    Data? data;

    factory Signup.fromJson(Map<String, dynamic> json) => Signup(
        token: json["token"],
        status: json["status"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "status": status,
        "data": data!.toJson(),
    };
}

class Data {
    Data({
        this.name,
        this.email,
        this.street,
        this.mobile,
        this.suburb,
        this.pincode,
        this.state,
        this.privillageCardNo,
        this.pickUpLocation,
        this.updatedAt,
        this.createdAt,
        this.id,
    });

    String ?name;
    String? email;
    String? street;
    String ?mobile;
    String? suburb;
    String ?pincode;
    String ?state;
    String? privillageCardNo;
    String? pickUpLocation;
    DateTime? updatedAt;
    DateTime? createdAt;
    int? id;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
        email: json["email"],
        street: json["street"],
        mobile: json["mobile"],
        suburb: json["suburb"],
        pincode: json["pincode"],
        state: json["state"],
        privillageCardNo: json["privillage_card_no"],
        pickUpLocation: json["pick_up_location"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "street": street,
        "mobile": mobile,
        "suburb": suburb,
        "pincode": pincode,
        "state": state,
        "privillage_card_no": privillageCardNo,
        "pick_up_location": pickUpLocation,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
    };
}

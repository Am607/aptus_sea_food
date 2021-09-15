// To parse this JSON data, do
//
//     final userInfo = userInfoFromJson(jsonString);

import 'dart:convert';

UserInfo userInfoFromJson(String str) => UserInfo.fromJson(json.decode(str));

String userInfoToJson(UserInfo data) => json.encode(data.toJson());

class UserInfo {
  UserInfo({
    this.success,
    this.data,
  });

  bool? success;
  Data? data;

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        success: json["success"],
        data: json["success"] == true ? Data.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.role,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.street,
    this.suburb,
    this.pincode,
    this.state,
    this.pickUpLocation,
    this.privillageCardNo,
  });

  int? id;
  String? name;
  String? email;
  String? mobile;
  String? role;
  dynamic emailVerifiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? street;
  String? suburb;
  String? pincode;
  String? state;
  String? pickUpLocation;
  String? privillageCardNo;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        mobile: json["mobile"],
        role: json["role"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        street: json["street"],
        suburb: json["suburb"],
        pincode: json["pincode"],
        state: json["state"],
        pickUpLocation: json["pick_up_location"],
        privillageCardNo: json["privillage_card_no"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "mobile": mobile,
        "role": role,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "street": street,
        "suburb": suburb,
        "pincode": pincode,
        "state": state,
        "pick_up_location": pickUpLocation,
        "privillage_card_no": privillageCardNo,
      };
}

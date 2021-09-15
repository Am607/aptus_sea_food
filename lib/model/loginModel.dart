// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  Login({
    this.token,
    this.status,
  });

  String? token;
  bool? status;

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        token: json["status"] == true ? json["token"] : '',
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "status": status,
      };
}

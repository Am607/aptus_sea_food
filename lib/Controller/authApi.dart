import 'dart:async';

import 'package:aptusseafood/constants/constants.dart';
import 'package:aptusseafood/model/loginModel.dart';
import 'package:aptusseafood/model/signupModel.dart';

import 'package:http/http.dart' as http;

class AuthApi {
  var client = http.Client();
  late String token;

  Future<Login> login({required String email, required String password}) async {
    print('get product called');
    final endpoint = 'login';
    final body = {'email': email, 'password': password};
    final reponse =
        await client.post(Uri.parse('$baseurl$endpoint'), body: body);
    print(reponse.body);
    Login data = loginFromJson(reponse.body);
    token = data.token!;
    return data;
  }

  Future<Signup> signup({
    required String name,
    required String password,
    required String email,
    required String street,
    required String mobile,
    required String suburb,
    required String pincode,
    required String state,
    required String pickupLocation,
  }) async {
    print('signup fuction called');

    final endPont = 'register';
    final body = {
      'email': email,
      'password': password,
      'name': name,
      'mobile': mobile,
      'suburb': suburb,
      'pincode': pincode,
      'state': state,
      'pick_up_location': pickupLocation,
      'street': street,
    };

    final response =
        await client.post(Uri.parse('$baseurl$endPont'), body: body);
    print(response.body);
    var data = signupFromJson(response.body);

  
    token = data.token!;
    return data;
  }
}

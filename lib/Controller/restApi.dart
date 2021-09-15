import 'package:aptusseafood/constants/constants.dart';
import 'package:aptusseafood/model/orderModel.dart';
import 'package:aptusseafood/model/planModel.dart';
import 'package:aptusseafood/model/privilageCardModel.dart';
import 'package:aptusseafood/model/productModel.dart';
import 'package:aptusseafood/model/userInfoModel.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class RsetAPi {
  var client = http.Client();
  final storage = new FlutterSecureStorage();

  Future<Dats> fetchPlan() async {
    print('fetch plan called');
    final endPoint = 'get-plans';
    final response = await client.get(Uri.parse('$baseurl$endPoint'));

    if (response.statusCode == 200) {
      // print(response.body);
      var joinString = response.body;
      return datsFromJson(joinString);
    } else {
      throw Exception('failed to load');
    }
  }

  //! for get products from api

  Future<Product> getProducts(String index) async {
    print('get product called');
    final endpoint = 'get-products/$index';
    final reponse = await client.get(Uri.parse('$baseurl$endpoint'));
    // print(reponse.body);
    return productFromJson(reponse.body);
  }

  //! for get user data from api

  Future<UserInfo> getUserInfo() async {
    final endPoint = 'get-data';

    // ignore: await_only_futures

    String? token = await storage.read(key: 'token');

    var header = {'Authorization': 'Bearer $token'};
    final response =
        await client.get(Uri.parse('$baseurl$endPoint'), headers: header);

    print(response.body);
    print('getUserInfoCalle');
    return userInfoFromJson(response.body);
  }
  //! for geting privilage card number

  Future<Card> getCartNo(
      {required String email, required String password}) async {
    print('get cardNoCalled');
    final endpoint = 'generete-card-number';

    String? token = await storage.read(key: 'token');

    var header = {'Authorization': 'Bearer $token'};

    final reponse =
        await client.post(Uri.parse('$baseurl$endpoint'), headers: header);
    print(reponse.body);
    Card data = cardFromJson(reponse.body);

    return data;
  }

  //! fot Order Product

  Future<OrderDataback> order({
    required String timeslot,
    required String orderamount,
    required String advance,
    required String planid,
    required String paymentmethod,
    required String price,
    required String name,
  }) async {
    print('signup fuction called');

    String? token = await storage.read(key: 'token');

    var header = {'Authorization': 'Bearer $token'};

    final endPont = 'order-product';
    final body = {
      'advance': advance,
      'order_amount': orderamount,
      'time_slot': timeslot,
      'payment_method': paymentmethod,
      'orderitems[0][price]': price,
      'orderitems[0][name] ': name,
      'plan_id': planid,
    };

    final response = await client.post(Uri.parse('$baseurl$endPont'),
        body: body, headers: header);
    print(response.body);

    var data = orderDatabackFromJson(response.body);

    return data;
  }
}

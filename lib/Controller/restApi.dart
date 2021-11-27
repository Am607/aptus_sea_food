import 'package:aptusseafood/Controller/localdb.dart';
import 'package:aptusseafood/constants/constants.dart';
import 'package:aptusseafood/model/bulkOrderModel.dart';
import 'package:aptusseafood/model/bulkProductModel.dart';
import 'package:aptusseafood/model/homeDelivery/category.dart';
import 'package:aptusseafood/model/homeDelivery/postal.dart';
import 'package:aptusseafood/model/orderModel.dart';
import 'package:aptusseafood/model/planModel.dart';
import 'package:aptusseafood/model/privilageCardModel.dart';
import 'package:aptusseafood/model/productModel.dart';
import 'package:aptusseafood/model/stripModel.dart';
import 'package:aptusseafood/model/userInfoModel.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:aptusseafood/model/bulkProductModel.dart' as a;

class RsetAPi {
  var client = http.Client();
  final storage = new FlutterSecureStorage();

  Future<Plan> fetchPlan() async {
    print('fetch plan called');
    final endPoint = 'get-plans';
    final response = await client.get(Uri.parse('$baseurl$endPoint'));

    if (response.statusCode == 200) {
      // print(response.body);
      var joinString = response.body;
      return planFromJson(joinString);
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

  Future<Carda> getCartNo() async {
    print('get cardNoCalled');
    final endpoint = 'generete-card-number';

    String? token = await storage.read(key: 'token');

    var header = {'Authorization': 'Bearer $token'};

    final reponse =
        await client.post(Uri.parse('$baseurl$endpoint'), headers: header);
    print(reponse.body);
    Carda data = cardFromJson(reponse.body);

    return data;
  }

  //! fot Order Product

  Future<OrderDataback> order({
    required String timeslot,
    required String orderamount,
    required String advance,
    // required String planid,
    required String paymentmethod,
    required String date,
    required String eftNO,
    // required String name,
  }) async {
    print('order fuction called');
    print(dbx.length);

    String? token = await storage.read(key: 'token');

    var header = {'Authorization': 'Bearer $token'};

    final endPont = 'order-product';
    final body = {
      'advance': advance,
      'order_amount': orderamount,
      'time_slot': timeslot,
      'date': date,
      'payment_method': paymentmethod,
      'plan_id': dbx[0].values.first?.planId,
      'eftpos': eftNO,
    };

    for (int i = 0; i < dbx.length; i++) {
      double qty =
          dbx[i].keys.first / double.parse('${dbx[i].values.first?.price}');
      print('quantity of each prduct => ${qty.toInt()}');
      body.addAll({'orderitems[$i][price]': "${dbx[i].keys.first.toString()}"});
      body.addAll({'orderitems[$i][id]': "${dbx[i].values.first?.id}"});
      body.addAll({'orderitems[$i][quantity]': "${qty.toInt()}"});
      body.addAll(
          {'orderitems[$i][name]': "${dbx[i].values.first?.productName}"});
    }

    // for (int i = 0; i < dbx.length; i++) {
    //   body.addAll(
    //       {'orderitems[$i][name]': "${dbx[i].values.first?.productName}"});
    // }

    int z = dbx.length + dby.length;
    print(z);
    // for (int a = dbx.length; a < z; a++) {
    //   body.addAll({'orderitems[$a][price]': "${dby[a - dbx.length]?.price}"});
    //   body.addAll({'orderitems[$a][id]': "${dby[a - dbx.length]?.id}"});
    // }

    // for (int a = dbx.length; a < z; a++) {
    //   body.addAll(
    //       {'orderitems[$a][name]': "${dby[a - dbx.length]?.productName}"});
    // }

    final response = await client.post(Uri.parse('$baseurl$endPont'),
        body: body, headers: header);
    print(response.body);

    var data = orderDatabackFromJson(response.body);

    return data;
  }

  //! //////////////////////////////////////////////////////////////
  // builk order apis

  Future<Suplier> getBulkProducts() async {
    print('get product called');
    final endpoint = 'get-bulk-products';
    final reponse = await client.get(Uri.parse('$baseurl$endpoint'));
    print(reponse.body);
    return suplierFromJson(reponse.body);
  }

  Future<BulkProduct> bulkOrder({
    required String modeofdelivery,
    required String address,
    required String transactionid,
    required String amount,
    required String abnNo,
    required String companyName,
    required String date,
    required String payLater,
  }) async {
    print('Bulk order fuction called');

    String? token = await storage.read(key: 'token');

    var header = {
      'Authorization': 'Bearer $token',
    };

    final endPont = 'bulk-order';

    var body = {
      'order_amount': amount,
      'mode_of_delivery': modeofdelivery,
      'address': address,
      'transaction_id': transactionid,
      'abn_number': abnNo,
      'company_name': companyName,
      'date': date,
      'pay_later': payLater
    };

    for (int i = 0; i < db.length; i++) {
      body.addAll({'orderitems[$i][id]': "${db[i].values.first?.id}"});
    }
    for (int i = 0; i < db.length; i++) {
      body.addAll(
          {'orderitems[$i][price]': "${db[i].values.first?.unitPrice}"});
    }
    for (int i = 0; i < db.length; i++) {
      body.addAll({'orderitems[$i][quantity]': "${db[i].keys.first}"});
    }

    final response = await client.post(Uri.parse('$baseurl$endPont'),
        body: body, headers: header);
    print(response.body);

    var data = bulkProductFromJson(response.body);

    return data;
  }

  Future<Strip> makeIntent(String amount) async {
    print(amount);
    print('make intetnt called');
    final endPoint = 'payment-intent?amount=$amount';
    final qparams = {'amount': amount};
    String qString = Uri(queryParameters: qparams).query;
    final response = await client.post(
      Uri.parse('$baseurl$endPoint'),
    );
    print(response.body);
    if (response.statusCode == 200) {
      // print(response.body);
      var joinString = response.body;
      return stripFromJson(joinString);
    } else {
      throw Exception('failed to load');
    }
  }

  Future<Postal> postalCodeSearch(String postalcode) async {
    print('post postal code called');
    final endPoint = 'search-postal-code';
    final qparams = {'code': postalcode};
    String qString = Uri(queryParameters: qparams).query;
    final response = await client.post(
      Uri.parse('$baseurl$endPoint$qString'),
    );
    print(response.body);
    if (response.statusCode == 200) {
      // print(response.body);
      var joinString = response.body;
      return postalFromJson(joinString);
    } else {
      throw Exception('failed to load');
    }
  }

  Future<HomedeliveryCategry> hdCategory() async {
    print('post category called');
    final endPoint = 'get-categories';

    final response = await client.get(
      Uri.parse('$baseurl$endPoint'),
    );
    print(response.body);
    if (response.statusCode == 200) {
      // print(response.body);
      var joinString = response.body;
      return homedeliveryCategryFromJson(joinString);
    } else {
      throw Exception('failed to load');
    }
  }
}

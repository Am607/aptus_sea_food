import 'package:aptusseafood/Controller/localdb.dart';
import 'package:aptusseafood/Controller/restApi.dart';
import 'package:aptusseafood/view/bulkOrder/paymentPage.dart';
import 'package:aptusseafood/view/bulkOrder/strip.dart';

import 'package:aptusseafood/widgets/CommonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class DetailsPagea extends StatelessWidget {
  final String modeof;
  final String address;

  DetailsPagea({Key? key, required this.address, required this.modeof})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<double> amount = [];
    for (int i = 0; i < db.length; i++) {
      double singlePrice = double.parse('${db[i].keys.first}') *
          double.parse('${db[i].values.first?.unitPrice}');
      amount.add(singlePrice);
    }

    var totalprice = amount.sum;
    print(db.length);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.blue),
        elevation: 0,
        backgroundColor: Colors.white30,
        title: Text(
          'Review',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: db.length,
              itemBuilder: (BuildContext ctxt, int index) {
                double singlePrice = double.parse('${db[index].keys.first}') *
                    double.parse('${db[index].values.first?.unitPrice}');
                return rowWidget(
                    name: '${db[index].values.first?.productName}',
                    price: '$singlePrice');
              }),

          // rowWidget(name: 'GST', price: '\$10'),
          rowWidget(name: 'Total', price: '\$$totalprice'),
        ],
      ),

      // rowWidget(name: 'Product1', price: '\$1000'),
      // rowWidget(name: 'Product2', price: '\$2000'),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 18, right: 18, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            appButtonTwo(
                function: () {
                  Navigator.pop(context);
                },
                name: 'Back'),
            appButtonTwo(
                function: () {
                  // RsetAPi restApi = RsetAPi();
                  // restApi
                  //     .bulkOrder(
                  //   modeofdelivery: modeof,
                  //   address: address,
                  //   transactionid: '1234',
                  //   amount: '$totalprice',
                  // )
                  //     .then((value) {
                  //   if (value.status == true) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => StripPage()));
                  // } else {
                  //   toast('Somthing went wrong');
                  // }
                  // });

                  // Navigator.pushAndRemoveUntil(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => PaymentPage()),
                  //   (Route<dynamic> route) => false,
                  // );
                },
                name: 'Confirm & pay')
          ],
        ),
      ),
    );
  }
}

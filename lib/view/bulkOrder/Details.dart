import 'package:aptusseafood/view/bulkOrder/paymentPage.dart';

import 'package:aptusseafood/widgets/CommonWidgets.dart';
import 'package:flutter/material.dart';

class DetailsPagea extends StatelessWidget {
  const DetailsPagea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          rowWidget(name: 'Product1', price: '\$1000'),
          rowWidget(name: 'Product2', price: '\$2000'),
          rowWidget(name: 'GST', price: '\$10'),
          rowWidget(name: 'Total', price: '\$3300'),
        ],
      ),
      bottomSheet: Padding(
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
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => PaymentPage()),
                    (Route<dynamic> route) => false,
                  );
                },
                name: 'Confirm & pay')
          ],
        ),
      ),
    );
  }
}

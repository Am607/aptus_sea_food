import 'package:aptusseafood/view/succesPage.dart';
import 'package:aptusseafood/widgets/CommonWidgets.dart';
import 'package:flutter/material.dart';

class Review extends StatelessWidget {
  const Review({Key? key}) : super(key: key);

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
          rowWidget(name: 'Name', price: 'Amal Muhammed'),
          rowWidget(name: 'Mail', price: 'amal@gmail.com'),
          rowWidget(name: 'PhoneNumber', price: '9188556633'),
          rowWidget(name: 'Product Ordered', price: 'Fish'),
          rowWidget(name: 'Special Requirments', price: ''),
          rowWidget(name: 'Pick Up', price: '20-may-2021'),
          rowWidget(name: 'Payment Mode', price: 'Cash'),
          rowWidget(name: 'Amount', price: '\$100'),
          rowWidget(name: 'Balance', price: '000'),
          rowWidget(name: 'Date of pickup', price: '12-02-21'),
          rowWidget(name: 'Location', price: 'shop'),
          rowWidget(name: 'Time slot', price: '6am-7am'),
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
                    MaterialPageRoute(builder: (context) => SuccessPage()),
                    (Route<dynamic> route) => false,
                  );
                },
                name: 'Confirm')
          ],
        ),
      ),
    );
  }
}

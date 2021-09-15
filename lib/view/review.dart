import 'package:aptusseafood/Controller/restApi.dart';
import 'package:aptusseafood/model/productModel.dart';
import 'package:aptusseafood/model/userInfoModel.dart';
import 'package:aptusseafood/view/succesPage.dart';
import 'package:aptusseafood/widgets/CommonWidgets.dart';
import 'package:flutter/material.dart';

class Review extends StatelessWidget {
  final String paymentMode;
  final Datuma? data;
  final double remaingAmount;
  Review(
      {Key? key,
      required this.paymentMode,
      required this.remaingAmount,
      this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(this.paymentMode);
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
      body: FutureBuilder<UserInfo>(
        future: RsetAPi().getUserInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return body(context, snapshot.data);
        },
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
                  RsetAPi restApi = RsetAPi();
                  restApi
                      .order(
                    timeslot: '6 am to 7 am',
                    orderamount: '1',
                    advance: '0',
                    planid: 'a',
                    paymentmethod: 'a',
                    price: 'a',
                    name: 'a',
                  )
                      .then((value) {
                    print(value.status);
                  });
                  // Navigator.pushAndRemoveUntil(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => SuccessPage()),
                  //   (Route<dynamic> route) => false,
                  // );
                },
                name: 'Confirm')
          ],
        ),
      ),
    );
  }

  body(BuildContext context, UserInfo? userInfo) {
    return ListView(
      children: [
        rowWidget(name: 'Name', price: '${userInfo!.data!.name}'),
        rowWidget(name: 'Mail', price: '${userInfo.data!.email}'),
        rowWidget(name: 'PhoneNumber', price: '${userInfo.data!.mobile}'),
        rowWidget(name: 'Product Ordered', price: '${this.data!.productName}'),
        rowWidget(name: 'Special Requirments', price: ''),
        rowWidget(name: 'Pick Up', price: '20-may-2021'),
        rowWidget(name: 'Payment Mode', price: '${this.paymentMode}'),
        rowWidget(name: 'Amount', price: '\$${this.data!.price}'),
        rowWidget(name: 'Balance', price: '${this.remaingAmount}'),
        rowWidget(name: 'Date of pickup', price: '12-02-21'),
        rowWidget(name: 'Location', price: '${userInfo.data!.pickUpLocation}'),
        rowWidget(name: 'Time slot', price: '6am-7am'),
        SizedBox(
          height: 200,
        )
      ],
    );
  }
}

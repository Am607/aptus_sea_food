import 'package:aptusseafood/Controller/localdb.dart';
import 'package:aptusseafood/Controller/restApi.dart';

import 'package:aptusseafood/model/userInfoModel.dart';
import 'package:aptusseafood/view/succesPage.dart';
import 'package:aptusseafood/widgets/CommonWidgets.dart';
import 'package:flutter/material.dart';

class Review extends StatelessWidget {
  final String paymentMode;
  final String? timesolte;

  final double remaingAmount;
  final double totalAmount;
  Review({
    Key? key,
    required this.paymentMode,
    required this.remaingAmount,
    required this.totalAmount,
    required this.timesolte,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    save() {
      double amount = double.parse('${this.totalAmount}');
      double balance = double.parse('${this.remaingAmount}');
      double advance = amount - balance;
      RsetAPi restApi = RsetAPi();
      restApi
          .order(
        timeslot: '${this.timesolte}',
        orderamount: '${this.totalAmount}',
        advance: '$advance',
        paymentmethod: '${this.paymentMode}',
      )
          .then((value) {
        print(value.status);
        if (value.status == true) {
          toast('Order Success');
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    SuccessPage(id: value.data!.orderId.toString())),
            (Route<dynamic> route) => false,
          );
        } else {
          toast('Something went wrong');
        }
      });
    }

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
                  save();
                },
                name: 'Confirm')
          ],
        ),
      ),
    );
  }

  body(BuildContext context, UserInfo? userInfo) {
    var length = dbx.length;
    return ListView(
      children: [
        Center(
          child: Text("Orderd Products"),
        ),
        ListView.builder(
            shrinkWrap: true,
            itemCount: dbx.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return rowWidget(
                  name: '${dbx[index]?.productName}',
                  price: '${dbx[index]?.price}');
            }),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text("Speial Products"),
          ),
        ),
        ListView.builder(
            shrinkWrap: true,
            itemCount: dby.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return rowWidget(
                  name: '${dby[index]?.productName}',
                  price: '${dby[index]?.price}');
            }),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text("Other Details"),
          ),
        ),
        rowWidget(name: 'Name', price: '${userInfo!.data!.name}'),
        rowWidget(name: 'Mail', price: '${userInfo.data!.email}'),
        rowWidget(name: 'PhoneNumber', price: '${userInfo.data!.mobile}'),
        // rowWidget(name: 'Product Ordered', price: '${this.data!.productName}'),
        // rowWidget(name: 'Special Requirments', price: ''),
        // rowWidget(name: 'Pick Up', price: '20-may-2021'),
        rowWidget(name: 'Payment Mode', price: '${this.paymentMode}'),
        rowWidget(name: 'Amount', price: '\$${this.totalAmount}'),
        rowWidget(name: 'Balance', price: '${this.remaingAmount}'),
        // rowWidget(name: 'Date of pickup', price: '12-02-21'),
        rowWidget(name: 'Location', price: '${userInfo.data!.pickUpLocation}'),
        rowWidget(name: 'Time slot', price: '${this.timesolte}'),
        SizedBox(
          height: 200,
        )
      ],
    );
  }
}

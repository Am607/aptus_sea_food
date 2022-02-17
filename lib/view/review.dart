import 'package:aptusseafood/Controller/localdb.dart';
import 'package:aptusseafood/Controller/restApi.dart';

import 'package:aptusseafood/model/userInfoModel.dart';
import 'package:aptusseafood/view/productPage.dart';
import 'package:aptusseafood/view/succesPage.dart';
import 'package:aptusseafood/widgets/CommonWidgets.dart';
import 'package:flutter/material.dart';

class Review extends StatefulWidget {
  final String paymentMode;
  final String? timesolte;
  final String? date;
  final String? eftNo;

  final double remaingAmount;
  final double totalAmount;
  Review({
    Key? key,
    required this.date,
    required this.eftNo,
    required this.paymentMode,
    required this.remaingAmount,
    required this.totalAmount,
    required this.timesolte,
  }) : super(key: key);

  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    save() {
      setState(() {
        isloading = true;
        toast('Order is Processing');
      });
      double amount = double.parse('${widget.totalAmount}');
      double balance = double.parse('${widget.remaingAmount}');

      RsetAPi restApi = RsetAPi();
      restApi
          .order(
        eftNO: '${widget.eftNo}',
        date: '${widget.date}',
        timeslot: '${widget.timesolte}',
        orderamount: '${widget.totalAmount}',
        advance: '$balance',
        paymentmethod: '${widget.paymentMode}',
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
        } else if (value.message == 'time slot fully booked') {
          isloading = false;
          toast('time slot fully booked');
        } else {
          isloading = false;
          toast('Something went wrong');
        }
      });
    }

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.blue),
          elevation: 0,
          backgroundColor: Colors.black,
          title: Text(
            'Review',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: isloading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : FutureBuilder<UserInfo>(
                future: RsetAPi().getUserInfo(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return body(context, snapshot.data);
                },
              ),
        bottomNavigationBar: navigationBar(
            next: () {
             isloading ? (){} : save();
            },
            context: context,
            back: () {
              Navigator.pop(context);
            },
            backname: "Back",
            nextName: "Confirm"));
  }

  body(BuildContext context, UserInfo? userInfo) {
    var length = dbx.length;
    return ListView(
      children: [
        SizedBox(
          height: 14,
        ),
        rowWidget(name: 'Name :', price: '${userInfo!.data!.name}'),
        rowWidget(name: 'Mail :', price: '${userInfo.data!.email}'),
        rowWidget(name: 'Phone Number :', price: '${userInfo.data!.mobile}'),
        Divider(
          thickness: 2,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 4, bottom: 12),
          child: Text(
            "Ordered Products",
            style: TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.w800),
          ),
        ),

        ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: dbx.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return rowWidget(
                  name: '${dbx[index].values.first?.productName}',
                  price: '${dbx[index].keys.first.toString()}');
            }),
        Divider(
          thickness: 2,
        ),
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Center(
        //     child: Text("Speial Products"),
        //   ),
        // ),
        // ListView.builder(
        //     shrinkWrap: true,
        //     itemCount: dby.length,
        //     itemBuilder: (BuildContext ctxt, int index) {
        //       return rowWidget(
        //           name: '${dby[index]?.productName}',
        //           price: '${dby[index]?.price}');
        //     }),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 4, bottom: 12),
          child: Text(
            "Other Details",
            style: TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.w800),
          ),
        ),

        // rowWidget(name: 'Product Ordered', price: '${this.data!.productName}'),

        rowWidget(name: 'Amount', price: '\$${widget.totalAmount}'),
        rowWidget(name: 'Payment Mode', price: '${widget.paymentMode}'),
        // rowWidget(name: 'Pick Up', price: '${this.date}'),
        rowWidget(name: 'Balance', price: '${widget.remaingAmount}'),
        rowWidget(name: 'Date of Pickup', price: '${widget.date}'),
        rowWidget(name: 'EFTPOS Receipt No', price: '${widget.eftNo}'),
        // rowWidget(name: 'Location', price: '${userInfo.data!.pickUpLocation}'),
        rowWidget(name: 'Time slot', price: '${widget.timesolte}'),
        SizedBox(
          height: 200,
        )
      ],
    );
  }
}

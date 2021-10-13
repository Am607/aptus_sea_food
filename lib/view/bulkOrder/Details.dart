import 'package:aptusseafood/Controller/localdb.dart';

import 'package:aptusseafood/view/bulkOrder/strip.dart';
import 'package:aptusseafood/view/productPage.dart';

import 'package:aptusseafood/widgets/CommonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailsPagea extends StatelessWidget {
  final String modeof;
  final String address;
  final String date;
  final String abnNo;
  final String companyNo;

  DetailsPagea(
      {Key? key,
      required this.address,
      required this.modeof,
      required this.abnNo,
      required this.companyNo,
      required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<double> amount = [];
    for (int i = 0; i < db.length; i++) {
      double singlePrice = double.parse('${db[i].keys.first}') *
          double.parse('${db[i].values.first?.unitPrice}');
      amount.add(singlePrice);
    }

    var totalpricea = amount.sum;
    double totalprice = double.parse((totalpricea).toStringAsFixed(2));
    print(db.length);
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.blue),
          elevation: 0,
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text(
            'Review',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: ListView(
          children: [
            SizedBox(
              height: 20,
            ),

            ListView.builder(
                shrinkWrap: true,
                itemCount: db.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  double singlePricea =
                      double.parse('${db[index].keys.first}') *
                          double.parse('${db[index].values.first?.unitPrice}');
                  double singlePrice =
                      double.parse((singlePricea).toStringAsFixed(2));
                  return rowWidgeta(
                      name: '${db[index].values.first?.productName}',
                      price: '$singlePrice');
                }),

            // rowWidget(name: 'GST', price: '\$10'),
            rowWidgeta(name: 'Total', price: '\$$totalprice'),
          ],
        ),

        // rowWidget(name: 'Product1', price: '\$1000'),
        // rowWidget(name: 'Product2', price: '\$2000'),

        bottomNavigationBar: navigationBara(
          widget: StripPage(
            abnNo: this.abnNo,
            companyNo: this.companyNo,
            date: this.date,
            totalPrice: totalprice,
            address: address,
            modeoff: modeof,
          ),
          // next: () {
          //   Navigator.pushReplacement(
          //       context,
          //       MaterialPageRoute(
          //           builder: (context) => StripPage(
          //                 abnNo: this.abnNo,
          //                 companyNo: this.companyNo,
          //                 date: this.date,
          //                 totalPrice: totalprice,
          //                 address: address,
          //                 modeoff: modeof,
          //               )));
          // },
          context: context,
          back: () {
            Navigator.pop(context);
          },
          backname: 'Back',
          // nextName: "Confirm"
        ));
  }
}

Column navigationBara({
  required BuildContext context,
  required void Function() back,
  required String backname,
  required Widget widget,
}) {
  final Size size = MediaQuery.of(context).size;
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Stack(
        children: [
          // Container(
          //   height: 70,
          //   decoration: BoxDecoration(
          //     color: Colors.white,

          //   ),
          //   child: CustomPaint(
          //     size: Size(size.width, 80),
          //     painter: BNBCustomPainter(),
          //   ),
          // ),
          Container(
            height: 70,
            decoration: BoxDecoration(color: Colors.black),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: back,
                  child: Container(
                    width: MediaQuery.of(context).size.width * .5,
                    child: Center(
                      child: Text(
                        '$backname',
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * .5,
                  child: Center(
                    child: widget,
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    ],
  );
}

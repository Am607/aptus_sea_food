import 'dart:core';

import 'package:aptusseafood/Controller/localdb.dart';
import 'package:aptusseafood/Controller/restApi.dart';
import 'package:aptusseafood/model/userInfoModel.dart';
import 'package:aptusseafood/view/productPage.dart';
import 'package:aptusseafood/view/succesPage.dart';
import 'package:aptusseafood/widgets/CommonWidgets.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:collection/collection.dart';

class HdReview extends StatefulWidget {
  const HdReview({Key? key}) : super(key: key);

  @override
  _HdReviewState createState() => _HdReviewState();
}

class _HdReviewState extends State<HdReview> {
  TextEditingController addresscount = TextEditingController();
  UserInfo? userInfo;
  @override
  void initState() {
    super.initState();
    inta();
  }

  bool isLoading = true;

  inta() async {
    RsetAPi().getUserInfo().then((value) {
      userInfo = value;
      setState(() {
        addresscount
          ..text =
              '${value.data?.street} ${value.data?.suburb}${value.data?.state} pin ${value.data?.pincode} no ${value.data?.mobile}';
        isLoading = false;
      });
    });
  }

  List<double> amount = [];
  var totalpricea;
  late double totalprice;
  late double finalTotalPrice;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    for (int i = 0; i < hddb.length; i++) {
      double singlePrice = double.parse('${hddb[i].keys.first}') *
          double.parse('${hddb[i].values.first?.price}');
      amount.add(singlePrice);
    }

    setState(() {
      totalpricea = amount.sum;

      totalprice = double.parse((totalpricea).toStringAsFixed(2));
      finalTotalPrice = 10 + totalprice;
    });
  }

  @override
  Widget build(BuildContext context) {
    save() {
      setState(() {
        toast('Order is Processing');
        isLoading = true;
      });

      RsetAPi restApi = RsetAPi();
      restApi
          .hdOrder(
        address: addresscount.text,
        deliveryCharge: '10',
        deliveryDate: '1-12-2021',
        totalAmount: '$totalprice',
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
          setState(() {
            isLoading = false;
          });
          
          toast('Something went wrong');
        }
      });
    }

    return Scaffold(
      bottomNavigationBar: navigationBar(
          next: () {
            isLoading ? (){} : save();
          },
          context: context,
          back: () {
            Navigator.pop(context);
          },
          backname: 'Back',
          nextName: 'Order Now'),
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text('DETAILS'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  rowWidgeta(name: 'Name :', price: '${userInfo?.data?.name}'),
                  rowWidgeta(name: 'Mail :', price: '${userInfo?.data?.email}'),
                  rowWidgeta(
                      name: 'Phone Number :',
                      price: '${userInfo?.data?.mobile}'),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 10, bottom: 5),
                    child: Text(
                      "Delivery Address",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 42, right: 42, bottom: 10),
                    child: TextFormField(
                      // initialValue: 'signup address found here',
                      maxLines: 5,
                      controller: addresscount,
                      decoration: InputDecoration(
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  width: 0, style: BorderStyle.none)),
                          fillColor: Color(0xFFF2F2F2),
                          hintStyle: GoogleFonts.poppins(fontSize: 16.0),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 24.0,
                            vertical: 10.0,
                          )),
                    ),
                  ),
                  rowWidgeta(name: 'Total amout :', price: '\$$totalprice'),
                  rowWidgeta(name: 'Delivery charge :', price: '\$10'),
                  rowWidgeta(
                      name: 'Sub amount :', price: '\$${totalprice + 10}'),
                ],
              ),
            ),
    );
  }
}

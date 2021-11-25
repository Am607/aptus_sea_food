import 'package:aptusseafood/constants/constants.dart';
import 'package:aptusseafood/view/homeDelivery/hdRiview.dart';
import 'package:aptusseafood/view/productPage.dart';
import 'package:aptusseafood/view/signUp.dart';
import 'package:aptusseafood/widgets/CommonWidgets.dart';
import 'package:flutter/material.dart';

class HdDetails extends StatefulWidget {
  const HdDetails({Key? key}) : super(key: key);

  @override
  _HdDetailsState createState() => _HdDetailsState();
}

class _HdDetailsState extends State<HdDetails> {
  @override
  TextEditingController qtController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: navigationBar(
          next: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HdReview()),
            );
          },
          context: context,
          back: () {
            Navigator.pop(context);
          },
          backname: 'Back',
          nextName: 'Next'),
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text('DETAILS'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.54,
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('$fishImage'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 10),
                    child: Text('Ablone',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 10),
                    child: Text('VIC, SA, TAS',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 10),
                    child: Text('FARMED',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, top: 12),
            child: Text(
              'Discription',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, top: 9),
            child: Text(
              '$dummyText',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          rowWidgetFour(name: 'Quantity'),
          Center(
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: appButtonBlacka(
                      function: () {}, name: "Add to Cart", context: context)))
        ],
      ),
    );
  }

  Widget rowWidgetFour({
    required String name,
  }) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 1),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
              ePos(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Divider(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  ePos() {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * .35,
        height: MediaQuery.of(context).size.height * .05,
        child: Center(
          child: Inputfield(
            isEmail: false,
            controller: qtController,
            keyboardType: TextInputType.text,
            text: "Qty",
          ),
        ),
      ),
    );
  }
}

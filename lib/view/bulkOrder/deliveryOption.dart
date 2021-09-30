import 'package:aptusseafood/Controller/restApi.dart';
import 'package:aptusseafood/constants/constants.dart';
import 'package:aptusseafood/view/bulkOrder/Details.dart';

import 'package:aptusseafood/widgets/CommonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ModeOfDelivery extends StatefulWidget {
  const ModeOfDelivery({Key? key}) : super(key: key);

  @override
  _ModeOfDeliveryState createState() => _ModeOfDeliveryState();
}

class _ModeOfDeliveryState extends State<ModeOfDelivery> {
  String isSlected = '';
  TextEditingController controllera = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    int();
  }

  int() async {
    RsetAPi().getUserInfo().then((value) {
      print('${value.data?.pickUpLocation}');
      controllera
        ..text =
            '${value.data?.pickUpLocation} ${value.data?.street} ${value.data?.suburb}${value.data?.state} pin ${value.data?.pincode} no ${value.data?.mobile}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "Mode of Delivery",
              style: TextStyle(fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Column(
              children: [
                appButton(
                    function: () {
                      setState(() {
                        isSlected = "PickUp";
                      });
                    },
                    name: "PickUp"),
                SizedBox(
                  height: 20,
                ),
                appButton(
                    function: () {
                      setState(() {
                        isSlected = "Delivery";
                      });
                    },
                    name: "Delivery")
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "Delivery Address",
              style: TextStyle(fontSize: 18),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 26, right: 26),
            child: TextFormField(
              // initialValue: 'signup address found here',
              maxLines: 5,
              controller: controllera,
              decoration: InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(width: 0, style: BorderStyle.none)),
                  fillColor: Color(0xFFF2F2F2),
                  hintStyle: GoogleFonts.poppins(fontSize: 16.0),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 10.0,
                  )),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              appButtonTwo(
                  function: () {
                    Navigator.pop(context);
                  },
                  name: 'Back'),
              SizedBox(
                width: 30,
              ),
              appButtonTwo(
                  function: () {
                    if (isSlected == '') {
                      toast('Please select Mode of delivery');
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailsPagea(
                                    address: controllera.text,
                                    modeof: isSlected,
                                  )));
                    }
                  },
                  name: 'Next')
            ],
          ),
        ),
      ),
    );
  }

  InkWell appButton({required void Function() function, required String name}) {
    return InkWell(
      onTap: function,
      child: Padding(
        padding: EdgeInsets.only(left: 25, right: 25, bottom: 2, top: 2),
        child: Container(
          height: 55,
          // margin: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: isSlected == name ? Color(buttonColor) : Color(0xFFDEDEDE),
          ),

          child: Center(
              child: Text(
            name,
            style: TextStyle(color: Colors.black, fontSize: 18),
          )),
        ),
      ),
    );
  }
}

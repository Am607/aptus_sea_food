import 'package:aptusseafood/Controller/restApi.dart';
import 'package:aptusseafood/constants/constants.dart';
import 'package:aptusseafood/view/bulkOrder/Details.dart';
import 'package:aptusseafood/view/productPage.dart';
import 'package:aptusseafood/view/signUp.dart';

import 'package:aptusseafood/widgets/CommonWidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class ModeOfDelivery extends StatefulWidget {
  const ModeOfDelivery({Key? key}) : super(key: key);

  @override
  _ModeOfDeliveryState createState() => _ModeOfDeliveryState();
}

class _ModeOfDeliveryState extends State<ModeOfDelivery> {
  TextEditingController controllera = TextEditingController();
  final TextEditingController abncount = TextEditingController();
  final TextEditingController companyCount = TextEditingController();
  GlobalKey<FormState> _form = GlobalKey<FormState>();

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

  List<String> modeOfD = ["PickUp", "Delivery"];

  String? isSlected;
  DateTime dateTime = DateTime.utc(2021, 10, 1);

  @override
  Widget build(BuildContext context) {
    var formatter = new DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(dateTime);
    print(formattedDate);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Text(
            "Mode of Delivery",
            style: TextStyle(fontSize: 18),
          ),
        ),
        body: ListView(
          children: [
            Padding(
                padding: const EdgeInsets.only(left: 25, top: 20, right: 25),
                child: timeSlot()
                // child: Column(
                //   children: [
                //     appButton(
                //         function: () {
                //           setState(() {
                //             isSlected = "PickUp";
                //           });
                //         },
                //         name: "PickUp"),
                //     SizedBox(
                //       height: 20,
                //     ),
                //     appButton(
                //         function: () {
                //           setState(() {
                //             isSlected = "Delivery";
                //           });
                //         },
                //         name: "Delivery")
                //   ],
                // ),
                ),
            isSlected == 'Delivery'
                ? Padding(
                    padding:
                        const EdgeInsets.only(left: 44, top: 10, bottom: 10),
                    child: Text(
                      "Delivery Address",
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                : Container(),
            isSlected == 'Delivery'
                ? Container(
                    padding: const EdgeInsets.only(left: 42, right: 42),
                    child: TextFormField(
                      // initialValue: 'signup address found here',
                      maxLines: 5,
                      controller: controllera,
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
                  )
                : Container(),
            Form(
              key: _form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 42, top: 10, right: 42),
                    width: MediaQuery.of(context).size.width * .5,
                    height: MediaQuery.of(context).size.height * .08,
                    child: Center(
                      child: Inputfield(
                        isEmail: false,
                        text: 'ABN number',
                        controller: abncount,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 42, top: 7, right: 42),
                    width: MediaQuery.of(context).size.width * .5,
                    height: MediaQuery.of(context).size.height * .08,
                    child: Center(
                      child: Inputfield(
                        isEmail: false,
                        text: 'Company name',
                        controller: companyCount,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 150,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: DateTime(2021, 10, 1),
                onDateTimeChanged: (DateTime newDateTime) {
                  dateTime = newDateTime;
                  setState(() {});
                },
              ),
            ),
            // Text(formattedDate),
          ],
        ),
        bottomNavigationBar: navigationBar(
            next: () {
              final isValid = _form.currentState!.validate();
              if (!isValid) {
                return;
              } else {
                if (isSlected == '') {
                  toast('Please select Mode of delivery');
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailsPagea(
                                abnNo: abncount.text,
                                companyNo: companyCount.text,
                                date: formattedDate,
                                address: controllera.text,
                                modeof: isSlected == null
                                    ? modeOfD[0]
                                    : '$isSlected',
                              )));
                }
              }
            },
            context: context,
            back: () {
              Navigator.pop(context);
            },
            backname: "Back",
            nextName: 'Next'));
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
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(12.0),
            color: isSlected == name ? Colors.black : Colors.white,
          ),

          child: Center(
              child: Text(
            name,
            style: TextStyle(
              fontSize: 18,
              color: isSlected == name ? Colors.white : Colors.black,
            ),
          )),
        ),
      ),
    );
  }

  Container timeSlot() {
    return Container(
        height: MediaQuery.of(context).size.height * .062,
        // width: MediaQuery.of(context).size.width * .5,
        margin: EdgeInsets.only(left: 18, right: 18),
        padding: EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(12),
            color: Colors.white),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            iconSize: 30,
            items: modeOfD.map(buildmenuItem).toList(),
            icon: Icon(
              Icons.arrow_drop_down,
              color: Colors.black,
            ),
            value: isSlected == null ? modeOfD[0] : isSlected,
            onChanged: (value) => setState(() => this.isSlected = value),
          ),
        ));
  }

  DropdownMenuItem<String> buildmenuItem(String item) {
    // setState(() {});
    return DropdownMenuItem(
      child: Text(item),
      value: item,
    );
  }
}

import 'package:aptusseafood/constants/constants.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

//! app eding section including Icon and app name
Padding headingSection(BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(top: 14.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 150,
          height: 150,
          child: Image.asset(appIocon1),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .01,
        ),
        Text(
          appName,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 18),
        ),
      ],
    ),
  );
}

//! app button Widget

InkWell appButton({required void Function() function, required String name}) {
  return InkWell(
    onTap: function,
    child: Padding(
      padding: EdgeInsets.only(left: 25, right: 25, bottom: 2, top: 2),
      child: Container(
        height: 52,
        // margin: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Color(buttonColor),
        ),

        child: Center(
            child: Text(
          name,
          style: TextStyle(color: Colors.white, fontSize: 20),
        )),
      ),
    ),
  );
}

InkWell appButtonBlack(
    {required void Function() function,
    required String name,
    required BuildContext context}) {
  return InkWell(
    onTap: function,
    child: Padding(
      padding: EdgeInsets.only(left: 25, right: 25, bottom: 2, top: 2),
      child: Container(
        height: 48,
        width: MediaQuery.of(context).size.width * .76,
        // margin: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.black,
            border: Border.all(color: Colors.white)),

        child: Center(
            child: Text(
          name,
          style: TextStyle(color: Colors.white, fontSize: 18),
        )),
      ),
    ),
  );
}

InkWell appButtonBlackc(
    {required void Function() function,
    required String name,
    required BuildContext context}) {
  return InkWell(
    onTap: function,
    child: Container(
      height: 48,
    
      // margin: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.black,
          border: Border.all(color: Colors.white)),

      child: Center(
          child: Text(
        name,
        style: TextStyle(color: Colors.white, fontSize: 18),
      )),
    ),
  );
}

InkWell appButtonBlacka(
    {required void Function() function,
    required String name,
    required BuildContext context}) {
  return InkWell(
    onTap: function,
    child: Padding(
      padding: EdgeInsets.only(left: 25, right: 25, bottom: 2, top: 2),
      child: Container(
        height: 48,
        width: MediaQuery.of(context).size.width * .76,
        // margin: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(1.0),
            color: Colors.black,
            ),

        child: Center(
            child: Text(
          name,
          style: TextStyle(color: Colors.white, fontSize: 18),
        )),
      ),
    ),
  );
}

InkWell appButtonTwo(
    {required void Function() function, required String name}) {
  return InkWell(
    onTap: function,
    child: Padding(
      padding: EdgeInsets.only(left: 2, right: 2, bottom: 2, top: 2),
      child: Container(
        height: 55,
        width: 140,
        // margin: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Color(buttonColor),
        ),

        child: Center(
            child: Text(
          name,
          style: TextStyle(color: Colors.white, fontSize: 20),
        )),
      ),
    ),
  );
}

//! row card Widget
Widget rowWidget({required String name, required String price}) {
  return Container(
    // padding: EdgeInsets.only(top: 10),
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
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w600),
            ),
            Text(
              '$price',
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          // child: Divider(
          //   color: Colors.grey,
          // ),
        ),
      ],
    ),
  );
}

Widget rowWidgeta({required String name, required String price}) {
  return Container(
    // padding: EdgeInsets.only(top: 10),
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
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w600),
            ),
            Text(
              '$price',
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Divider(
            color: Colors.grey,
          ),
        ),
      ],
    ),
  );
}

toast(String text) {
  return Fluttertoast.showToast(
      msg: "$text",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0);
}
toastRed(String text) {
  return Fluttertoast.showToast(
      msg: "$text",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}

toasta({required BuildContext context, required String msg}) =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("$msg"),
    ));
class InputfieldA extends StatelessWidget {
  final String text;
  final Icon? icon;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? value;
  final bool isEmail;
  final ValueChanged<String>? onChangedFuntion;
  InputfieldA(
      {this.icon,
      required this.text,
      this.keyboardType,
      this.controller,
      required this.isEmail,
      this.onChangedFuntion,
      this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .06,
      child: TextFormField(
        onChanged: onChangedFuntion,
        keyboardType: keyboardType,
        controller: controller,
        validator: isEmail
            ? (text) {
                if (!(text!.contains('@')) || text.isEmpty) {
                  return 'Enter a valid email address';
                }
                return null;
              }
            : (tex) {
                if (tex!.isEmpty) {
                  return "Enter valid $text";
                }
                return null;
              },
        decoration: InputDecoration(
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(width: .5, style: BorderStyle.solid,color: Colors.black)),
           fillColor: Colors.white,
            hintStyle: GoogleFonts.poppins(fontSize: 16.0),
            prefixIcon: icon,
            hintText: text,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 24.0,
              // vertical: 10.0,
            )),
      ),
    );
  }
}
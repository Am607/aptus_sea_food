import 'package:aptusseafood/constants/constants.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

//! app eding section including Icon and app name
Padding headingSection() {
  return Padding(
    padding: EdgeInsets.only(top: 55.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 150,
          height: 150,
          child: Image.asset(appIocon),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          appName,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 21),
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
        height: 55,
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
    margin: EdgeInsets.only(left: 20, right: 20, top: 1),
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Divider(
            color: Colors.grey,
          ),
        ),
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
      ],
    ),
  );
}

toast(String text) => Fluttertoast.showToast(
    msg: "$text",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0);

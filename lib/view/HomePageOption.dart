import 'package:aptusseafood/view/bulkOrder/HomepageB.dart';
import 'package:aptusseafood/view/logiinScreen.dart';
import 'package:aptusseafood/view/planPage.dart';

import 'package:aptusseafood/widgets/CommonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePageOption extends StatelessWidget {
  const HomePageOption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          actions: [
            InkWell(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              child: Center(
                child: Text(
                  "Logout",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            )
          ],
        ),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              headingSection(),
              midText(),
              SizedBox(
                height: 30,
              ),
              appButton(
                  function: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PlanPage())),
                  name: "Xmax Exppress"),
              SizedBox(
                height: 30,
              ),
              appButton(
                  function: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePageB())),
                  name: "Bulk Order"),
            ],
          ),
        ),
      ),
    );
  }

  Container midText() {
    return Container(
      padding: EdgeInsets.only(top: 40),
      child: Text(
        'Please Choose One \n Option',
        style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 20),
        textAlign: TextAlign.center,
      ),
    );
  }
}

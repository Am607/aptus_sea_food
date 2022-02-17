import 'package:aptusseafood/Controller/localdb.dart';
import 'package:aptusseafood/view/bulkOrder/HomepageB.dart';
import 'package:aptusseafood/view/homeDelivery/home.dart';
import 'package:aptusseafood/view/logiinScreen.dart';
import 'package:aptusseafood/view/planPage.dart';

import 'package:aptusseafood/widgets/CommonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePageOption extends StatefulWidget {
  const HomePageOption({Key? key}) : super(key: key);

  @override
  _HomePageOptionState createState() => _HomePageOptionState();
}

class _HomePageOptionState extends State<HomePageOption> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.black,
          title: Align(
            alignment: Alignment.center,
            child: Text(
              'Home',
              style: TextStyle(color: Colors.white),
            ),
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              child: Center(
                child: Text(
                  "Logout",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            )
          ],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          child: Column(
            children: [
              // SizedBox(
              //   height: 30,
              // ),
              headingSection(context),
              midText(),
              SizedBox(height: MediaQuery.of(context).size.height * .04),
              Container(
                height: MediaQuery.of(context).size.height * .075,
                child: appButtonBlack(
                    function: () {
                      int() {
                        print(db);
                        db.clear();
                        print(db);
                        dbx.clear();
                        print(dbx);
                        dbxId.clear();
                      }

                      int();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => PlanPage()));
                    },
                    name: "Xmas Express",
                    context: context),
              ),
              // SizedBox(
              //   height: 30,
              // ),
              SizedBox(height: MediaQuery.of(context).size.height * .04),
              Container(
                height: MediaQuery.of(context).size.height * .075,
                child: appButtonBlack(
                    function: () {
                      int() {
                        print(db);
                        db.clear();
                        print(db);
                        dbx.clear();
                        print(dbx);
                        dbxId.clear();
                      }

                      int();
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePageB()))
                          .then((value) => setState(() {}));
                    },
                    name: "Bulk Order",
                    context: context),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .04),
              Container(
                height: MediaQuery.of(context).size.height * .075,
                child: appButtonBlack(
                    function: () {
                      hddb.clear();
                      print(hddb);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeDeliveryPage()));
                      // .then((value) => setState(() {}));
                    },
                    name: "Home Delivery",
                    context: context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container midText() {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Text(
        'Browse Your Service',
        style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 17),
        textAlign: TextAlign.center,
      ),
    );
  }
}

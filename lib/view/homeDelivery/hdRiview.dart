import 'package:aptusseafood/view/productPage.dart';
import 'package:aptusseafood/widgets/CommonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HdReview extends StatefulWidget {
  const HdReview({Key? key}) : super(key: key);

  @override
  _HdReviewState createState() => _HdReviewState();
}

class _HdReviewState extends State<HdReview> {
  TextEditingController addresscount = TextEditingController();

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
          nextName: 'Pay'),
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text('DETAILS'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            rowWidgeta(name: 'Name :', price: 'Amal'),
            rowWidgeta(name: 'Mail :', price: 'a@gmail.com'),
            rowWidgeta(name: 'Phone Number :', price: '9188535353'),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10, bottom: 5),
              child: Text(
                "Delivery Address",
                style: TextStyle(fontSize: 16),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 42, right: 42, bottom: 10),
              child: TextFormField(
                // initialValue: 'signup address found here',
                maxLines: 5,
                controller: addresscount..text = 'signup address found here',
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
            ),
            rowWidgeta(name: 'Total amout :', price: '\$100'),
            rowWidgeta(name: 'Delivery charge :', price: '\$10'),
            rowWidgeta(name: 'Sub amount :', price: '\$110'),
          ],
        ),
      ),
    );
  }
}

import 'package:aptusseafood/view/HomePageOption.dart';
import 'package:aptusseafood/widgets/CommonWidgets.dart';
import 'package:flutter/material.dart';

class ConfirmPage extends StatelessWidget {
  const ConfirmPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(height: 120),
          newMethod(name: "Your order has been Confirmed"),
          SizedBox(height: 3),
          newMethod(
              name:
                  "A copy  of  your invoice has \n been sent to your registerd \n             email address"),
          SizedBox(height: 60),
          Center(
            child: Text(
              'Thanks for Shoping \n with Aptus Seafood',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(bottom: 60),
        child: appButton(
            function: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => HomePageOption()));
            },
            name: "Back to Home Page"),
      ),
    );
  }

  Row newMethod({
    required String name,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$name',
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}

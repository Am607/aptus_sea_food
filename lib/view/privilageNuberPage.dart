import 'package:aptusseafood/view/HomePageOption.dart';
import 'package:aptusseafood/widgets/CommonWidgets.dart';
import 'package:flutter/material.dart';

class PrivilagePage extends StatelessWidget {
  const PrivilagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(height: 120),
          newMethod(id: '123', name: "Order Number"),
          SizedBox(height: 30),
          newMethod(id: '123464646', name: "privilage card No"),
          SizedBox(height: 100),
          Center(
            child: Text(
              'Thanks for choosing \n     Aptus Seafood',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(bottom: 60),
        child: appButton(
            function: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomePageOption()),
                (Route<dynamic> route) => false,
              );
            },
            name: "Back to Home Page"),
      ),
    );
  }

  Row newMethod({required String name, required String id}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$name : ',
          style: TextStyle(fontSize: 18),
        ),
        Text(
          '$id',
          style: TextStyle(fontSize: 18),
        )
      ],
    );
  }
}

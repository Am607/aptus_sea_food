import 'package:aptusseafood/constants/constants.dart';
import 'package:aptusseafood/view/privilageNuberPage.dart';
import 'package:aptusseafood/widgets/CommonWidgets.dart';
import 'package:flutter/material.dart';

class SuccessPage extends StatelessWidget {
  final String id;
  SuccessPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 70,
          ),
          roundTick(),
          SizedBox(
            height: 30,
          ),
          Center(
              child: Text(
            'Your order is Successfull',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          )),
          SizedBox(
            height: 10,
          ),
          newMethod(id: '$id', name: "Order Id"),
          SizedBox(
            height: 30,
          ),
          Center(
              child: Text(
            '     Click here to Generate \n Order Number and Privilage \n       Card number to get \n offers and updation through \n               out the Year',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          )),
          SizedBox(
            height: 30,
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: appButtonBlack(
                function: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => PrivilagePage()),
                    (Route<dynamic> route) => false,
                  );
                },
                name: "Click",
                context: context),
          )
        ],
      ),
    );
  }

  Center roundTick() {
    return Center(
      child: Container(
        height: 150,
        width: 150,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(200),
                color: Colors.black,
              ),
            ),
            Center(
              child: Container(
                height: 130,
                width: 130,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 1.5),
                  borderRadius: BorderRadius.circular(200),
                  color: Colors.black,
                ),
              ),
            ),
            Center(
              child: Icon(
                Icons.check_rounded,
                size: 120,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}

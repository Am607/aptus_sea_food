import 'package:aptusseafood/Controller/restApi.dart';
import 'package:aptusseafood/model/privilageCardModel.dart';
import 'package:aptusseafood/view/HomePageOption.dart';
import 'package:aptusseafood/widgets/CommonWidgets.dart';
import 'package:flutter/material.dart';

class PrivilagePage extends StatelessWidget {
  const PrivilagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Carda>(
        future: RsetAPi().getCartNo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return body(data: snapshot.data);
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 60),
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: appButtonBlack(
              function: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomePageOption()),
                  (Route<dynamic> route) => false,
                );
              },
              name: "Back to Home Page",
              context: context),
        ),
      ),
    );
  }

  ListView body({Carda? data}) {
    return ListView(
      children: [
        SizedBox(height: 120),
        SizedBox(height: 30),
        newMethod(
            id: '${data!.data!.privillageCardNo}', name: "Privilage card No"),
        SizedBox(height: 100),
        Center(
          child: Text(
            'Thanks for choosing \n     Aptus Sea Foods',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
          ),
        ),
      ],
    );
  }
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

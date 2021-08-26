import 'package:aptusseafood/constants/constants.dart';
import 'package:aptusseafood/view/productPage.dart';
import 'package:aptusseafood/view/signUp.dart';
import 'package:aptusseafood/widgets/CommonWidgets.dart';
import 'package:flutter/material.dart';

class PlanPage extends StatefulWidget {
  const PlanPage({Key? key}) : super(key: key);

  @override
  _PlanPageState createState() => _PlanPageState();
}

enum Selected { silverPlane, goldPlane, platinumPlane }
bool isSelected = true;
String index = '';

class _PlanPageState extends State<PlanPage> {
  @override
  Widget build(BuildContext context) {
    setState(() {
      print(index);
    });
    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            timeSlot(),
            SizedBox(
              height: 30,
            ),
            itemCard(
                name: "Silver Plan",
                isSelcted: index,
                function: () {
                  setState(() {
                    index = 'Silver Plan';
                  });
                }),
            SizedBox(
              height: 25,
            ),
            itemCard(
                name: 'Gold Plan',
                isSelcted: index,
                function: () {
                  setState(() {
                    index = 'Gold Plan';
                  });
                }),
            SizedBox(
              height: 25,
            ),
            itemCard(
                name: 'Platinum Plan',
                isSelcted: index,
                function: () {
                  setState(() {
                    index = 'Platinum Plan';
                  });
                }),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  appButtonTwo(
                      function: () {
                        Navigator.pop(context);
                      },
                      name: 'Back'),
                  SizedBox(
                    width: 30,
                  ),
                  appButtonTwo(
                      function: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductPage(index: index,)));
                      },
                      name: 'Next')
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  InkWell itemCard(
      {required String name,
      required String isSelcted,
      required void Function() function}) {
    return InkWell(
      onTap: function,
      child: Stack(
        children: [
          backround(isSelcted: isSelcted, name: name),
          Positioned(
            left: 50,
            bottom: 25,
            child: planeName(name: name),
          ),
          Positioned(
              left: 55,
              top: 15,
              child: Text(
                'Plan details',
                style: TextStyle(
                  fontSize: 18,
                ),
              )),
          Positioned(
            right: 45,
            bottom: 22,
            child: Center(
              child: Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(appIocon))),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container planeName({required String name}) {
    return Container(
      width: 180,
      height: 40,
      child: Container(
        padding: EdgeInsets.only(left: 12, top: 10),
        child: Text(
          name,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
    );
  }

  Container backround({required String isSelcted, required String name}) {
    return Container(
      margin: EdgeInsets.only(right: 26, left: 26, top: 2, bottom: 2),
      height: 110,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isSelcted == name ? Color(0xFF5EC401) : Color(0xFFDEDEDE)),
    );
  }

  Container timeSlot() {
    return Container(
      padding: EdgeInsets.only(top: 45, right: 26, left: 26),
      child: Inputfield(
        icon: Icon(Icons.insert_emoticon),
        text: "Choose a time slote",
      ),
    );
  }
}

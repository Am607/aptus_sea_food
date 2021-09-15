import 'package:aptusseafood/constants/constants.dart';
import 'package:aptusseafood/view/bulkOrder/deliveryOption.dart';

import 'package:aptusseafood/view/signUp.dart';
import 'package:aptusseafood/widgets/CommonWidgets.dart';
import 'package:flutter/material.dart';

class HomePageB extends StatefulWidget {
  const HomePageB({Key? key}) : super(key: key);

  @override
  _HomePageBState createState() => _HomePageBState();
}

enum Selected { silverPlane, goldPlane, platinumPlane }
bool isSelected = true;
String index = '';

class _HomePageBState extends State<HomePageB> {
  @override
  Widget build(BuildContext context) {
    setState(() {
      print(index);
    });
    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            SizedBox(
              height: 45,
            ),
            itemCard(
                name: "ProductOne",
                isSelcted: index,
                function: () {
                  print('colorchange');
                  setState(() {
                    index = 'Silver Plan';
                  });
                }),
            itemCard(
                name: "ProductTwo",
                isSelcted: index,
                function: () {
                  print('colorchange');
                  setState(() {
                    index = 'Silver Plan';
                  });
                }),
            itemCard(
                name: "ProductTree",
                isSelcted: index,
                function: () {
                  print('colorchange');
                  setState(() {
                    index = 'Silver Plan';
                  });
                }),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(top: 40, bottom: 20),
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
                          builder: (context) => ModeOfDelivery()));
                },
                name: 'Next')
          ],
        ),
      ),
    );
  }

  itemCard(
      {required String name,
      required String isSelcted,
      required void Function() function}) {
    return Stack(
      children: [
        backround(isSelcted: isSelcted, name: name, function: function),
        Positioned(
            left: 0,
            right: 0,
            top: 15,
            child: Center(
              child: Text(
                '$name',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            )),
        Positioned(
          bottom: 30,
          left: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              newMethod(),
              SizedBox(
                width: 12,
              ),
              texTField(),
              SizedBox(
                width: 12,
              ),
              appButton(
                  function: () {
                    print('added');
                  },
                  name: 'Add'),
            ],
          ),
        ),
      ],
    );
  }

  Container newMethod() {
    return Container(
      width: 90,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Center(child: Text('100Kg')),
    );
  }

  Widget backround(
      {required String isSelcted,
      required String name,
      required void Function() function}) {
    return InkWell(
      onTap: function,
      child: Container(
        margin: EdgeInsets.only(right: 26, left: 26, top: 2, bottom: 20),
        padding: EdgeInsets.all(0),
        height: 90,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isSelcted == name ? Color(0xFF5EC401) : Color(0xFFDEDEDE)),
      ),
    );
  }

  //! app button edited
  InkWell appButton({required void Function() function, required String name}) {
    return InkWell(
      onTap: function,
      child: Container(
        width: 100,
        height: 40,
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
    );
  }

  Container texTField() {
    return Container(
      height: 40,
      width: 110,
      // padding: EdgeInsets.only(top: 45, right: 26, left: 26),
      child: Center(
        child: Inputfield(
          isEmail: false,
          keyboardType: TextInputType.number,
          text: "Enter",
        ),
      ),
    );
  }
}

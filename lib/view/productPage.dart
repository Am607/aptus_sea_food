import 'package:aptusseafood/constants/constants.dart';
import 'package:aptusseafood/view/details.dart';
import 'package:aptusseafood/view/planPage.dart';
import 'package:aptusseafood/view/signUp.dart';
import 'package:aptusseafood/widgets/CommonWidgets.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key, required String index}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.blue),
        elevation: 0,
        backgroundColor: Colors.white30,
        title: Text(
          index,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .62,
            margin: EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 0),
            child: ListView(
              children: [
                item(name: 'Prawns-1kg', price: 300),
                item(name: 'Prawns-1kg', price: 300),
                item(name: 'Prawns-1kg', price: 300),
                item(name: 'Prawns-1kg', price: 300),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * .22,
            margin: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 0),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 6,
                    bottom: 10,
                  ),
                  child: Text(
                    'Special Requirments',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                timeSlot(),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      appButtonTwo(
                          function: () {
                            Navigator.pop(context);
                          },
                          name: 'Back'),
                      appButtonTwo(
                          function: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailsPage()));
                          },
                          name: 'Next')
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Container item({required String name, required int price}) {
    return Container(
      margin: EdgeInsets.only(top: 12),
      child: Center(
        child: Row(
          children: [
            SizedBox(
              width: 20,
            ),
            Container(
                width: 220,
                child: Text(
                  name,
                  style: TextStyle(fontSize: 17),
                )),
            Text(
              '\$$price',
              style: TextStyle(fontSize: 17),
            )
          ],
        ),
      ),
      height: 50,
      decoration: BoxDecoration(
          color: Color(greyColor), borderRadius: BorderRadius.circular(12)),
    );
  }

  Container timeSlot() {
    return Container(
      padding: EdgeInsets.only(top: 0, right: 0, left: 0, bottom: 5),
      child: Inputfield(
        icon: Icon(Icons.insert_emoticon),
        text: "Choose a time slote",
      ),
    );
  }
}

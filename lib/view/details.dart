import 'package:aptusseafood/Controller/localdb.dart';
import 'package:aptusseafood/constants/constants.dart';
import 'package:aptusseafood/model/productModel.dart';
import 'package:aptusseafood/view/productPage.dart';
import 'package:aptusseafood/view/review.dart';
import 'package:aptusseafood/view/signUp.dart';

import 'package:aptusseafood/widgets/CommonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class DetailsPage extends StatefulWidget {
  final Datuma? data;
  final String? timeSlote;
  final String date;

  DetailsPage({Key? key, this.data, this.timeSlote, required this.date})
      : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final TextEditingController priceController = TextEditingController();
  final TextEditingController recieptController = TextEditingController();
  GlobalKey<FormState> _form = GlobalKey<FormState>();
  final items = ['Cash', 'EFTPOS'];
  String value = '';
  String price = '0';
  double remaingAmount = 0;

  @override
  Widget build(BuildContext context) {
    List<double> amount = [];
    for (int i = 0; i < dbx.length; i++) {
      amount.add(double.parse("${dbx[i].keys.first.toString()}"));
    }
    for (int i = dbx.length; i < (dbx.length + dby.length); i++) {
      amount.add(double.parse("${dby[i - dbx.length]?.price}"));
    }
    var pricea = double.parse(amount.sum.toStringAsFixed(2));
    
    print(amount);
    print(pricea);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.blue),
        elevation: 0,
        backgroundColor: Colors.black,
        title: Text(
          'Details',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 20,
          ),
          rowWidgeta(name: 'Total', price: '\$$pricea'),
          rowWidgetTwo(name: 'Payment Mode'),
          rowWidgetFour(name: 'EFTPOS Receipt No'),
          rowWidgetTree(name: 'Remaining Amount'),
        ],
      ),
      bottomNavigationBar: navigationBar(
          next: () {
            setState(() {
              remaingAmount = double.parse('$price');
            });

            if (priceController.text == '') {
              toast('Please Remaining Amount');
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Review(
                          eftNo: recieptController.text,
                          date: widget.date,
                          timesolte: widget.timeSlote,
                          totalAmount: pricea,
                          paymentMode: value == '' ? items[0] : value,
                          remaingAmount: remaingAmount)));
            }
          },
          context: context,
          back: () {
            Navigator.pop(context);
          },
          backname: 'Back',
          nextName: 'Next'),
    );
  }

  Widget rowWidgetTwo({required String name}) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 1),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w600),
              ),
              Container(
                height: 42,
                width: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(greyColor)),
                child: Center(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      iconSize: 30,
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                      ),
                      value: value == '' ? items[0] : value,
                      items: items.map(buildMenuItem).toList(),
                      onChanged: (value) => setState(
                        () => this.value = value!,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Divider(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) =>
      DropdownMenuItem(value: item, child: Text(item));

  Widget rowWidgetTree({
    required String name,
  }) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 1),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w600),
              ),
              priceSlot(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Divider(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  priceSlot() {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * .45,
        height: 42,
        child: Center(
          child: Form(
            key: _form,
            child: Inputfield(
              onChangedFuntion: (a) => setState(() => this.price = a),
              isEmail: false,
              controller: priceController,
              keyboardType: TextInputType.number,
              text: "Enter Amount",
            ),
          ),
        ),
      ),
    );
  }

  Widget rowWidgetFour({
    required String name,
  }) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 1),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w600),
              ),
              ePos(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Divider(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  ePos() {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * .45,
        height: 42,
        child: Center(
          child: Inputfield(
            onChangedFuntion: (a) => setState(() => this.price = a),
            isEmail: false,
            controller: recieptController,
            keyboardType: TextInputType.text,
            text: "Receipt No",
          ),
        ),
      ),
    );
  }
}

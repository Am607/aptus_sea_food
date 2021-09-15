import 'package:aptusseafood/constants/constants.dart';
import 'package:aptusseafood/model/productModel.dart';
import 'package:aptusseafood/view/review.dart';
import 'package:aptusseafood/view/signUp.dart';
import 'package:aptusseafood/widgets/CommonWidgets.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  final Datuma? data;
  DetailsPage({Key? key, this.data}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final TextEditingController priceController = TextEditingController();

  final items = ['Cash', 'Epos'];
  String value = '';
  String price = '0';
  double remaingAmount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.blue),
        elevation: 0,
        backgroundColor: Colors.white30,
        title: Text(
          'Details',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        children: [
          rowWidget(name: 'Total', price: '\$${widget.data!.price}.'),
          SizedBox(
            height: 5,
          ),
          rowWidgetTwo(name: 'Paymentmode'),
          SizedBox(
            height: 5,
          ),
          rowWidget(name: 'EFTPOS Reciept No', price: '001245656'),
          SizedBox(
            height: 15,
          ),
          rowWidgetTree(name: 'Remain Amount'),
        ],
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(left: 18, right: 18, bottom: 32),
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
                  setState(() {
                    remaingAmount = double.parse('$price');
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Review(
                              data: widget.data,
                              paymentMode: value == '' ? items[0] : value,
                              remaingAmount: remaingAmount)));
                },
                name: 'Next')
          ],
        ),
      ),
    );
  }

  Widget rowWidgetTwo({required String name}) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 1),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Divider(
              color: Colors.grey,
            ),
          ),
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
                height: 45,
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
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Divider(
              color: Colors.grey,
            ),
          ),
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
        ],
      ),
    );
  }

  priceSlot() {
    return Center(
      child: Container(
        width: 180,
        height: 45,
        child: Center(
          child: Inputfield(
            onChangedFuntion: (a) => setState(() => this.price = a),
            isEmail: false,
            controller: priceController,
            keyboardType: TextInputType.number,
            text: "Enter amount",
          ),
        ),
      ),
    );
  }
}

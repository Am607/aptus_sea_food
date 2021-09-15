import 'package:aptusseafood/Controller/restApi.dart';
import 'package:aptusseafood/constants/constants.dart';
import 'package:aptusseafood/model/productModel.dart';

import 'package:aptusseafood/view/details.dart';

import 'package:aptusseafood/view/signUp.dart';

import 'package:aptusseafood/widgets/CommonWidgets.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  final String planName;
  final String index;

  const ProductPage({
    Key? key,
    required this.index,
    required this.planName,
  }) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final TextEditingController timeSloteController = TextEditingController();
  late Future<Product> products;

  String isSelectedId = "";
  late int selectdIndex;

  @override
  void initState() {
    super.initState();
    inta();
  }

  inta() {
    products = RsetAPi().getProducts(widget.index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.blue),
        elevation: 0,
        backgroundColor: Colors.white30,
        title: Text(
          widget.planName,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: FutureBuilder<Product>(
        future: products,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final data = snapshot.data;
          // print('the product name is ${data?.data?[0].productName}');
          return body(context, product: data);
        },
      ),
    );
  }

  ListView body(BuildContext context, {Product? product}) {
    return ListView(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * .62,
          margin: EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 0),
          child: ListView.builder(
              itemCount: product!.data!.length,
              itemBuilder: (context, i) {
                String? name = product.data![i].productName;
                double price = double.parse(product.data![i].price);

                return item(
                    name: name == null ? 'No name' : name,
                    price: price,
                    id: product.data![i].id.toString(),
                    function: () {
                      setState(() {
                        isSelectedId = product.data![i].id.toString();
                        selectdIndex = i;
                      });
                    });
              }),
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
                          isSelectedId == ''
                              ? toast('Please Choose at least on product')
                              : Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailsPage(
                                            data: product.data![selectdIndex],
                                          )));
                        },
                        name: 'Next')
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  item(
      {required String name,
      required double price,
      required String id,
      required void Function() function}) {
    return InkWell(
      onTap: function,
      child: Container(
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
                    '$name',
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
            color: isSelectedId == id ? Color(0xFF5EC401) : Color(greyColor),
            borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Container timeSlot() {
    return Container(
      padding: EdgeInsets.only(top: 0, right: 0, left: 0, bottom: 5),
      child: Inputfield(
        isEmail: false,
        controller: timeSloteController,
        icon: Icon(Icons.insert_emoticon),
        text: "Choose a time slote",
      ),
    );
  }
}

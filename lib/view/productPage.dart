import 'package:aptusseafood/Controller/localdb.dart';
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
  final String timeSlote;

  const ProductPage({
    Key? key,
    required this.index,
    required this.planName,
    required this.timeSlote,
  }) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final TextEditingController timeSloteController = TextEditingController();
  late Future<Product> products;

  //! multy selection
  String isSelectedId = "";
  List<bool> list = [];
  void isAdded({bool isAdded = false}) {
    list.add(isAdded);
  }

//!-------------------------------------
  //! for special requirments
  List<String> plans = ['choose a special product'];
  List<Datuma>? dat;
  String? valuea;
  Datuma? dataDby;

  Datuma? data;
  late int selectdIndex;

  @override
  void initState() {
    super.initState();
    inta();
  }

  inta() {
    products = RsetAPi().getProducts(widget.index).then((value) {
      if (value.status == 200) {
        //! for special requirements
        dat = value.platinumProducts;
        for (dynamic a = 0; a < value.platinumProducts?.length; a++) {
          setState(() {
            plans.add('${dat?[a].productName}     ${dat?[a].price}');
          });
          print(plans);
        }

        //! for multi selection
        for (int i = 0; i < int.parse('${value.data?.length}'); i++) {
          isAdded(isAdded: false);
        }
      }
      return value;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('time slote => ${widget.timeSlote}');
    print(list);
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
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
                height: MediaQuery.of(context).size.height * .083,
                width: MediaQuery.of(context).size.width * .78,
                // width: MediaQuery.of(context).size.width * .85,
                margin: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                padding: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(greyColor)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    iconSize: 30,
                    items: plans.map(buildmenuItem).toList(),
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                    value: valuea == null ? plans[0] : valuea,
                    onChanged: (value) => setState(() {
                      this.valuea = value;

                      valuea == 'choose a special product'
                          ? print('Somthing')
                          : this.dataDby = dat?.singleWhere((element) =>
                              //! dont edit space sencitive //! dont edit
                              '${element.productName}     ${element.price}' ==
                              value);
                      print(value);
                      print(dataDby?.price);
                    }),
                  ),
                )),

            Container(
              height: 40,
              width: 40,
              child: FloatingActionButton(
                onPressed: () {
                  if (dataDby == null) {
                    toast('Please Choose a Special Product');
                  } else {
                    dby.add(dataDby);
                    toast('${dataDby?.productName} is added');
                  }
                },
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              width: 3,
            )
            // Container(
            //     height: MediaQuery.of(context).size.height * .083,
            //     width: MediaQuery.of(context).size.width * .225,
            //     child: appButton(function: () {}, name: 'Add'))
          ]),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 10),
            child: Container(
              // height: MediaQuery.of(context).size.height * .087,
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
                        dbx.length == 0
                            ? toast('Please Choose at least on product')
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailsPage(
                                          data: data,
                                          timeSlote: widget.timeSlote,
                                        )));
                      },
                      name: 'Next')
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  body(BuildContext context, {Product? product}) {
    print(dbx);
    return product?.data?.length.toString() == '0'
        ? Center(
            child: Text('No Product Found'),
          )
        : ListView.builder(
            padding: EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 0),
            itemCount: product?.data?.length,
            itemBuilder: (context, i) {
              String? name = product?.data?[i].productName;
              double price = double.parse('${product?.data?[i].price}');

              return item(
                  index: i,
                  name: name == null ? 'No name' : name,
                  price: price,
                  id: '${product?.data?[i].id}',
                  function: () {
                    setState(() {
                      list[i] = !list[i];

                      if (list[i] == true) {
                        dbx.add(product?.data?[i]);
                      } else if (list[i] == false) {
                        print('this one is called');

                        dbx.removeWhere(
                            (element) => element?.id == product?.data?[i].id);
                      }
                      data = product?.data?[i];

                      isSelectedId = '${product?.data?[i].id}';
                      selectdIndex = i;
                    });
                  });
            });
  }

  item(
      {required int index,
      required String name,
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
            color: list[index] == true ? Color(0xFF5EC401) : Color(greyColor),
            borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Container timeSlot() {
    return Container(
      height: MediaQuery.of(context).size.height * .086,
      padding: EdgeInsets.only(top: 0, right: 0, left: 0, bottom: 5),
      child: Inputfield(
        isEmail: false,
        controller: timeSloteController,
        text: "Special products",
      ),
    );
  }

  DropdownMenuItem<String> buildmenuItem(String item) {
    // setState(() {});
    return DropdownMenuItem(
      child: Text(item),
      value: item,
    );
  }
}

import 'package:aptusseafood/Controller/localdb.dart';
import 'package:aptusseafood/Controller/restApi.dart';
import 'package:aptusseafood/constants/constants.dart';
import 'package:aptusseafood/model/bulkProductModel.dart';
import 'package:aptusseafood/view/bulkOrder/deliveryOption.dart';

import 'package:aptusseafood/view/signUp.dart';
import 'package:aptusseafood/widgets/CommonWidgets.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

class HomePageB extends StatefulWidget {
  const HomePageB({Key? key}) : super(key: key);

  @override
  _HomePageBState createState() => _HomePageBState();
}

class _HomePageBState extends State<HomePageB> {
  TextEditingController controller = TextEditingController();

  // GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late Future<Suplier> data;
  Datum? datam;
  String isSelected = '';
  String index = '';
  @override
  void initState() {
    super.initState();
    int();
  }

  int() async {
    print(db);
    data = RsetAPi().getBulkProducts();
  }

  GlobalKey<FormState> _form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // key: _scaffoldKey,
        appBar: AppBar(
          actions: [
            Container(
              padding: EdgeInsets.only(top: 10, right: 10),
              child: Badge(
                badgeColor: Colors.red,
                shape: BadgeShape.circle,
                toAnimate: false,
                badgeContent:
                    Text('${db.length}', style: TextStyle(color: Colors.white)),
                child: Icon(Icons.shopping_cart),
              ),
            ),
            SizedBox(
              width: 10,
            ),
          ],
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.blue),
          title: Text(
            'Bulk Order',
            style: TextStyle(color: Colors.blue),
          ),
          elevation: 0,
        ),
        body: FutureBuilder<Suplier>(
            future: data,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // print(snapshot.data?.toJson());
                return ListView.builder(
                    itemCount: snapshot.data?.data?.length,
                    itemBuilder: (context, index) {
                      // plans.add(data!);

                      return itema(
                          id: '${snapshot.data?.data?[index].id}',
                          price: double.parse(
                              '${snapshot.data?.data?[index].unitPrice}'),
                          data: snapshot.data?.data?[index],
                          function: () {
                            setState(() {
                              isSelected = '${snapshot.data?.data?[index].id}';
                              datam = snapshot.data?.data?[index];
                            });
                          },
                          name: "${snapshot.data?.data?[index].productName}");
                    });
              } else if (snapshot.hasError) {
                return Text('error');
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }),

        //!------------------------action button

        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // newMethod("o", 'a'),
            SizedBox(
              width: MediaQuery.of(context).size.width * .1,
            ),
            Form(
              key: _form,
              child: Container(
                width: MediaQuery.of(context).size.width * .4,
                height: MediaQuery.of(context).size.height * .07,
                // padding: EdgeInsets.only(top: 45, right: 26, left: 26),
                child: Center(
                  child: Inputfield(
                    controller: controller,
                    isEmail: false,
                    keyboardType: TextInputType.number,
                    text: "Qty",
                  ),
                ),
              ),
            ),

            SizedBox(
              width: MediaQuery.of(context).size.width * .05,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .2,
            ),
            appButton(
                function: () {
                  if (datam.toString() == 'null') {
                    // MotionToast.warning(
                    //         title: "Warning Motion Toast",
                    //         titleStyle: TextStyle(fontWeight: FontWeight.bold),
                    //         description: "This is a Warning")
                    //     .show(context);

                    toast('Please Select one product');
                  } else if (controller.text == '') {
                    toast('Enter quantity');
                  } else {
                    if (double.parse('${datam?.availableQuantity}') <
                        double.parse('${controller.text}')) {
                      toast('Selected Quantity is not available');
                    }
                    var qty = double.parse(controller.text);
                    db.add({qty: datam});
                    toast('Item added');
                    print(db);

                    // controller.clear();
                    setState(() {});
                  }
                },
                name: 'Add'),
          ],
        ),
        bottomNavigationBar: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20, left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                appButtonTwo(
                    function: () {
                      Navigator.pop(context);
                    },
                    name: 'Back'),
                // SizedBox(
                //   width: MediaQuery.of(context).size.width * .05,
                // ),
                appButtonTwo(
                    function: () {
                      if (db.length == 0) {
                        toast('please add at least one product');
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ModeOfDelivery()));
                      }
                    },
                    name: 'Next')
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Container body({Datum? data}) {
  //   return Container(
  //     height: MediaQuery.of(context).size.height * .7,
  //     child: ListView(
  //       children: [
  //         SizedBox(
  //           height: 45,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  itema(
      {required String name,
      required double price,
      required String id,
      required Datum? data,
      required void Function() function}) {
    return InkWell(
      onTap: function,
      child: Container(
        margin: EdgeInsets.only(top: 12, left: 12, right: 12),
        child: Center(
          child: Row(
            children: [
              SizedBox(
                width: 8,
              ),
              Container(
                  child: Expanded(
                child: Text(
                  '$name',
                  style: TextStyle(fontSize: 17),
                ),
              )),
              Expanded(
                child: Text(
                  '${data?.availableQuantity}/\$$price ${data?.unit}',
                  style: TextStyle(fontSize: 17),
                ),
              )
            ],
          ),
        ),
        height: 50,
        decoration: BoxDecoration(
            color: isSelected == id ? Color(0xFF5EC401) : Color(greyColor),
            borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  // itemCard(
  //     {required String name,
  //     Datum? data,
  //     required String isSelcted,
  //     required void Function() function}) {
  //   return Stack(
  //     children: [
  //       backround(isSelcted: isSelcted, name: name, function: function),
  //       Positioned(
  //           left: 0,
  //           right: 0,
  //           top: 10,
  //           child: Center(
  //             child: Text(
  //               '$name',
  //               style: TextStyle(
  //                 fontSize: 18,
  //               ),
  //             ),
  //           )),
  //       Positioned(
  //         bottom: 30,
  //         left: 30,
  //         child: Row(
  //           // mainAxisAlignment: MainAxisAlignment.end,
  //           // crossAxisAlignment: CrossAxisAlignment.center,
  //           children: [
  //             newMethod("${data?.availableQuantity}", "${data?.unit}"),
  //             SizedBox(
  //               width: MediaQuery.of(context).size.width * .05,
  //             ),
  //             texTField(),
  //             SizedBox(
  //               width: MediaQuery.of(context).size.width * .05,
  //             ),
  //             appButton(
  //                 function: () {
  //                   print('added');
  //                 },
  //                 name: 'Add'),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Container newMethod(String qty, String unit) {
    return Container(
      width: MediaQuery.of(context).size.width * .24,
      height: MediaQuery.of(context).size.height * .07,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Center(child: Text('$qty $unit')),
    );
  }

  Widget backround(
      {required String isSelcted,
      required String name,
      required void Function() function}) {
    return InkWell(
      onTap: function,
      child: Container(
        margin: EdgeInsets.only(right: 15, left: 15, top: 2, bottom: 20),
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
        width: MediaQuery.of(context).size.width * .24,
        height: MediaQuery.of(context).size.height * .07,
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
}

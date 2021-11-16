import 'package:aptusseafood/Controller/localdb.dart';
import 'package:aptusseafood/Controller/restApi.dart';
import 'package:aptusseafood/model/productModel.dart';
import 'package:aptusseafood/view/details.dart';
import 'package:aptusseafood/view/signUp.dart';
import 'package:aptusseafood/view/xmasCartPage.dart';
import 'package:aptusseafood/widgets/CommonWidgets.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductPage extends StatefulWidget {
  final String planName;
  final String index;
  final String timeSlote;
  final String date;

  const ProductPage(
      {Key? key,
      required this.index,
      required this.planName,
      required this.timeSlote,
      required this.date})
      : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final TextEditingController timeSloteController = TextEditingController();
  TextEditingController textController = TextEditingController();
  late Future<Product> products;

  //! for search in product list
  List<Datuma>? productsList;
  List<Datuma>? newDataList;

//! for qty button
  List<int> qtyList = [];
  void addQty() {
    qtyList.add(1);
  }

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
    i();
    inta();
    newDataList = productsList;
  }

  i() async {
    await RsetAPi().getProducts(widget.index).then((value) {
      setState(() {
        productsList = value.data;
        newDataList = value.data;
      });

      return value;
    });
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
          addQty();
        }
      }
      return value;
    });
  }

  onItemChanged(String value) {
    setState(() {
      newDataList = productsList
          ?.where((item) => item.productName!.toLowerCase().contains(value))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    // print('time slote => ${widget.timeSlote}');
    // print(list);
    print(newDataList);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          actions: [
            widget.index == '3'
                ? Container(
                    padding: EdgeInsets.only(top: 10, right: 10),
                    child: Badge(
                      badgeColor: Colors.blue,
                      shape: BadgeShape.circle,
                      toAnimate: false,
                      badgeContent: Text('${dbx.length}',
                          style: TextStyle(color: Colors.white)),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => XmaxCartPage(),
                              ),
                            );
                          },
                          child: Icon(Icons.shopping_cart)),
                    ),
                  )
                : SizedBox(),
            SizedBox(
              width: 10,
            ),
          ],
          iconTheme: IconThemeData(color: Colors.white),
          elevation: 0,
          backgroundColor: Colors.black,
          title: Text(
            "${widget.planName} Plan",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: ListView(
          children: [
            widget.index == '3'
                ? Container(
                    margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                    height: MediaQuery.of(context).size.height * .05,
                    //  width: MediaQuery.of(context).size.width * .8,
                    child: TextField(
                      onChanged: (value) {
                        onItemChanged(value);
                      },
                      decoration: InputDecoration(
                          isDense: true,
                          hintText: 'Search',
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: -8),
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: .5),
                              borderRadius: BorderRadius.circular(8))),
                    ))
                : SizedBox(height: 0),
            FutureBuilder<Product>(
              future: products,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.hasData) {
                    final data = snapshot.data;
                    //TODO: important to fix;
                    // productsList = snapshot.data?.data;
                    // newDataList = snapshot.data?.data;
                    return body(context, product: data);
                  }
                }
                // final List<Datuma>? products = data?.data;
                // print('the product name is ${data?.data?[0].productName}');
                return Center(
                  child: Text('No Data'),
                );
              },
            ),
          ],
        ),
        bottomNavigationBar: navigationBar(
            context: context,
            next: () {
              dbx.length == 0
                  ? toast('Please Choose at least on product')
                  : Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailsPage(
                                date: widget.date,
                                data: data,
                                timeSlote: widget.timeSlote,
                              )));
            },
            nextName: "Next",
            back: () {
              Navigator.pop(context);
            },
            backname: "Back"),
      ),
    );
  }

  body(BuildContext context, {Product? product}) {
    print(dbx);
    return product?.data?.length.toString() == '0'
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text('No Product Found'),
            ),
          )
        : SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: 1,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    // padding:
                    //     EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 0),
                    itemCount: newDataList?.length,
                    itemBuilder: (context, i) {
                      String? name = newDataList?[i].productName;
                      double price = double.parse('${newDataList?[i].price}');
                      bool isAdded = false;

                      return item(
                          index: i,
                          name: name == null ? 'No name' : name,
                          price: price,
                          id: '${newDataList?[i].id}',
                          function: widget.index == '3'
                              ? () {
                                  late int a = 0;
                                  for (int b = 0;
                                      b < product!.data!.length;
                                      b++) {
                                    setState(() {
                                      if ('${newDataList?[i].id}' ==
                                          '${product.data?[b].id}') {
                                        a = b;
                                      }
                                    });
                                  }

                                  setState(() {
                                    list[a] = !list[a];
                                    product.data?[a].price =
                                        '${price * qtyList[i]}';
                                    product.data?[a].quantity = '${qtyList[i]}';

                                    if (list[a] == true) {
                                      dbx.add(product.data?[a]);
                                      dbxId.add('${product.data?[a].id}');
                                    } else if (list[a] == false) {
                                      dbx.removeWhere((element) =>
                                          element?.id == product.data?[a].id);
                                      dbxId.remove('${product.data?[a].id}');
                                    }
                                    data = product.data?[a];

                                    isSelectedId = '${product.data?[a].id}';
                                    selectdIndex = a;
                                  });
                                }
                              : () {
                                  setState(() {
                                    list[i] = !list[i];

                                    if (list[i] == true) {
                                      dbx.add(product?.data?[i]);
                                    } else if (list[i] == false) {
                                      dbx.removeWhere((element) =>
                                          element?.id == product?.data?[i].id);
                                    }
                                    data = product?.data?[i];

                                    isSelectedId = '${product?.data?[i].id}';
                                    selectdIndex = i;
                                  });
                                });
                    }),
              ],
            ),
          );
  }

  item(
      {required int index,
      required String name,
      required double price,
      required String id,
      required void Function() function}) {
    return InkWell(
      onTap: widget.index == '3' ? null : function,
      child: Container(
        height: MediaQuery.of(context).size.height * .12,
        padding: EdgeInsets.zero,
        // padding: EdgeInsets.only(
        //   left: 12,
        // ),
        margin: EdgeInsets.only(top: 3),
        child: Center(
          child: ListTile(
            // leading: CircleAvatar(
            //   child: Text(
            //     '$name'[0],
            //   ),
            // ),
            title: Text(
              '$name',
              style: TextStyle(
                fontSize: 15,
                color: dbxId.contains(id) == true ? Colors.white : Colors.black,
              ),
            ),
            subtitle: Text(
              '\$${price * qtyList[index]}',
              style: TextStyle(
                fontSize: 15,
                color: dbxId.contains(id) == true ? Colors.white : Colors.black,
              ),
            ),
            trailing: widget.index == '3'
                ? Container(
                    width: MediaQuery.of(context).size.width * .3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * .2,
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Theme.of(context).accentColor),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                  onTap: () {
                                    if (dbxId.contains(id) == true) {
                                      toastRed('Please Remove From CART');
                                    } else {
                                      if (qtyList[index] > 0) {
                                        setState(() {
                                          qtyList[index]--;
                                        });
                                      }
                                    }
                                  },
                                  child: Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                    size: 16,
                                  )),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 3),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 3, vertical: 2),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    color: Colors.white),
                                child: Text(
                                  '${qtyList[index]}',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                              InkWell(
                                  onTap: () {
                                    if (dbxId.contains(id) == true) {
                                      toastRed('Please Remove From CART');
                                    } else {
                                      qtyList[index]++;
                                      setState(() {});
                                    }
                                  },
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 16,
                                  )),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: InkWell(
                              onTap: function,
                              child: list[index] == true
                                  ? Icon(
                                      Icons.remove_shopping_cart,
                                      color: Colors.white,
                                    )
                                  : Icon(
                                      Icons.add_shopping_cart,
                                      color: Colors.black,
                                    )),
                        ),
                      ],
                    ),
                  )
                : SizedBox(),
          ),
        ),
        decoration: BoxDecoration(
          color: dbxId.contains(id) == true ? Colors.black : Colors.white,
          // borderRadius: BorderRadius.circular(12)
        ),
      ),
      // Divider(
      //   thickness: 1,
      //   color: Colors.black12,
      // )
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

//! for bazier curve
// class WaveClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     print(size.height.toString());
//     var path = Path();
//     path.lineTo(0, size.height);
//     var oneStart = Offset(size.width / 5, size.height);
//     var oneEnd = Offset(size.width / 2.25, size.height - 50);
//     path.quadraticBezierTo(oneStart.dx, oneStart.dy, oneEnd.dx, oneEnd.dy);
//     var twoStart = Offset(size.width - (size.width / 3.24), size.height - 105);
//     var twoEnd = Offset(size.width, size.height - 10);
//     path.quadraticBezierTo(twoStart.dx, twoStart.dy, twoEnd.dx, twoEnd.dy);
//     path.lineTo(size.width, 0);
//     path.close();

//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }
// class WaveClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     print(size.height.toString());
//     var path = Path();
//     path.lineTo(0, size.height);
//     var oneStart = Offset(size.width / 3, size.height);
//     var oneEnd = Offset(size.width / 3, size.height);
//     path.quadraticBezierTo(oneStart.dx, oneStart.dy, oneEnd.dx, oneEnd.dy);
//     var twoStart = Offset(size.width - (size.width / 3.24), size.height - 105);
//     var twoEnd = Offset(size.width, size.height);
//     // path.quadraticBezierTo(twoStart.dx, twoStart.dy, twoEnd.dx, twoEnd.dy);
//     path.lineTo(size.width, size.height);
//     path.close();

//     // int curveHeight = 40;
//     // Offset controlPoint = Offset(size.width / 2, size.height + curveHeight);
//     // Offset endPoint = Offset(size.width, size.height - curveHeight);

//     // // Path path = Path()
//     //   ..lineTo(0, size.height - curveHeight)
//     //   ..quadraticBezierTo(
//     //       controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy)
//     //   ..lineTo(size.width, 0)
//     //   ..close();

//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }

Column navigationBar(
    {required void Function() next,
    required BuildContext context,
    required void Function() back,
    required String backname,
    required String nextName}) {
  final Size size = MediaQuery.of(context).size;
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Stack(
        children: [
          // Container(
          //   height: 70,
          //   decoration: BoxDecoration(
          //     color: Colors.white,

          //   ),
          //   child: CustomPaint(
          //     size: Size(size.width, 80),
          //     painter: BNBCustomPainter(),
          //   ),
          // ),
          Container(
            height: 70,
            decoration: BoxDecoration(color: Colors.black),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: back,
                  child: Container(
                    width: MediaQuery.of(context).size.width * .5,
                    child: Center(
                      child: Text(
                        '$backname',
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: next,
                  child: Container(
                    width: MediaQuery.of(context).size.width * .5,
                    child: Center(
                      child: Text(
                        '$nextName',
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    ],
  );
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 0); // Start
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.3, 0);
    path.quadraticBezierTo(size.width * 0.39, 0, size.width * 0.44, 25);
    path.arcToPoint(Offset(size.width * 0.55, 20),
        radius: Radius.circular(25.0), clockwise: false);

    path.quadraticBezierTo(size.width * 0.58, 0, size.width * 0.7, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 20);
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

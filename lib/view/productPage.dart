import 'package:aptusseafood/Controller/localdb.dart';
import 'package:aptusseafood/Controller/restApi.dart';
import 'package:aptusseafood/model/productModel.dart';
import 'package:aptusseafood/view/details.dart';
import 'package:aptusseafood/view/signUp.dart';
import 'package:aptusseafood/widgets/CommonWidgets.dart';
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
          elevation: 0,
          backgroundColor: Colors.black,
          title: Text(
            "${widget.planName} Plan",
            style: TextStyle(color: Colors.white),
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
        ? Center(
            child: Text('No Product Found'),
          )
        : SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: 1,
                ),
                // Container(
                //   height: 130,
                //   decoration: BoxDecoration(
                //       image: DecorationImage(
                //           image: AssetImage(seafood), fit: BoxFit.cover)),
                // ),
                // Center(
                //   child: Padding(
                //     padding: const EdgeInsets.only(top: 30),
                //     child: Text(
                //       "${widget.planName} Plan",
                //       style: TextStyle(
                //           color: Colors.black,
                //           fontSize: 18,
                //           fontWeight: FontWeight.bold),
                //     ),
                //   ),
                // ),
                // Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // children: [
                //   Container(
                //       height: MediaQuery.of(context).size.height * .069,
                //       width: MediaQuery.of(context).size.width * .78,
                //       // width: MediaQuery.of(context).size.width * .85,
                //       margin:
                //           EdgeInsets.only(left: 20, top: 10, bottom: 10),
                //       padding: EdgeInsets.only(left: 20, right: 10),
                //       decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(12),
                //           color: Colors.white,
                //           border: Border.all(color: Colors.black)),
                //       child: DropdownButtonHideUnderline(
                //         child: DropdownButton<String>(
                //           iconSize: 30,
                //           items: plans.map(buildmenuItem).toList(),
                //           icon: Icon(
                //             Icons.arrow_drop_down,
                //             color: Colors.black,
                //           ),
                //           value: valuea == null ? plans[0] : valuea,
                //           onChanged: (value) => setState(() {
                //             this.valuea = value;

                //             valuea == 'choose a special product'
                //                 ? print('Somthing')
                //                 : this.dataDby = dat?.singleWhere(
                //                     (element) =>
                //                         //! dont edit space sencitive //! dont edit
                //                         '${element.productName}     ${element.price}' ==
                //                         value);
                //             print(value);
                //             print(dataDby?.price);
                //           }),
                //         ),
                //       )),

                //   Container(
                //     height: 35,
                //     width: 35,
                //     child: FloatingActionButton(
                //       backgroundColor: Colors.black,
                //       onPressed: () {
                //         if (dataDby == null) {
                //           toast('Please Choose a Special Product');
                //         } else {
                //           dby.add(dataDby);
                //           toast('${dataDby?.productName} is added');
                //         }
                //       },
                //       child: Icon(
                //         Icons.add,
                //         color: Colors.white,
                //       ),
                //     ),
                //   ),
                //   SizedBox(
                //     width: 3,
                //   )
                //   // Container(
                //   //     height: MediaQuery.of(context).size.height * .083,
                //   //     width: MediaQuery.of(context).size.width * .225,
                //   //     child: appButton(function: () {}, name: 'Add'))
                // ]),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    // padding:
                    //     EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 0),
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

  //   itema(
  //     {required String name,
  //     required double price,
  //     required String id,
  //     required Datum? data,
  //     required void Function() function}) {
  //   return InkWell(
  //     onTap: function,
  //     child: Container(
  //       height: MediaQuery.of(context).size.height * .12,
  //       margin: EdgeInsets.only(top: 5),
  //       padding: EdgeInsets.zero,

  //       child: Center(
  //         child: ListTile(
  //           title: Text(
  //             '$name',
  //             style: TextStyle(
  //               fontSize: 15,
  //               color: isSelected == id ? Colors.white : Colors.black,
  //             ),
  //           ),
  //           subtitle: Text(
  //             '${data?.availableQuantity} ${data?.unit}',
  //             style: TextStyle(
  //               fontSize: 15,
  //               color: isSelected == id ? Colors.white : Colors.black,
  //             ),
  //           ),
  //           trailing: Text(
  //             '\$$price',
  //             style: TextStyle(
  //               fontSize: 15,
  //               color: isSelected == id ? Colors.white : Colors.black,
  //             ),
  //           ),
  //         ),
  //       ),

  //       // child: Row(
  //       //   children: [
  //       //     Container(
  //       //       height: 20,
  //       //       child: ListTile(
  //       //         title: Text(
  //       //           '$name',
  //       //           style: TextStyle(fontSize: 17),
  //       //         ),
  //       //       ),
  //       //     ),

  //       //     SizedBox(
  //       //       width: 8,
  //       //     ),

  //       //     Expanded(
  //       //       child: Text(
  //       //         '${data?.availableQuantity}/\$$price ${data?.unit}',
  //       //         style: TextStyle(fontSize: 17),
  //       //       ),
  //       //     )
  //       //   ],
  //       // ),

  //       decoration: BoxDecoration(
  //         color: isSelected == id ? Colors.black : Colors.white,
  //       ),
  //     ),
  //   );
  // }

  item(
      {required int index,
      required String name,
      required double price,
      required String id,
      required void Function() function}) {
    return InkWell(
      onTap: function,
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
                color: list[index] == true ? Colors.white : Colors.black,
              ),
            ),
            subtitle: Text(
              '\$$price',
              style: TextStyle(
                fontSize: 15,
                color: list[index] == true ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        decoration: BoxDecoration(
          color: list[index] == true ? Colors.black : Colors.white,
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

import 'package:aptusseafood/Controller/localdb.dart';
import 'package:aptusseafood/Controller/restApi.dart';
import 'package:aptusseafood/constants/constants.dart';

import 'package:aptusseafood/model/homeDelivery/hdProductDetailsModel.dart'
    as model;
import 'package:aptusseafood/view/homeDelivery/hdCart.dart';
import 'package:aptusseafood/view/homeDelivery/hdRiview.dart';
import 'package:aptusseafood/view/productPage.dart';
import 'package:aptusseafood/view/signUp.dart';
import 'package:aptusseafood/widgets/CommonWidgets.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HdDetails extends StatefulWidget {
  final String id;

  const HdDetails({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _HdDetailsState createState() => _HdDetailsState();
}

class _HdDetailsState extends State<HdDetails> {
  final TextEditingController qtController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static final _formKey = GlobalKey<FormState>();

  late model.HdDetails data;
  bool isLoadign = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    inta();
  }

  inta() async {
    RsetAPi().hdProductDetails(widget.id).then((value) => setState(() {
          data = value;
          isLoadign = false;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      bottomNavigationBar: navigationBar(
          next: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HdReview()),
            );
          },
          context: context,
          back: () {
            Navigator.pop(context);
          },
          backname: 'Back',
          nextName: 'Next'),
      appBar: AppBar(
        actions: [
          Container(
            padding: EdgeInsets.only(top: 10, right: 10),
            child: Badge(
              badgeColor: Colors.blue,
              shape: BadgeShape.circle,
              toAnimate: false,
              badgeContent:
                  Text('${hddb.length}', style: TextStyle(color: Colors.white)),
              child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HdCartPage(),
                      ),
                    ).then(
                      (value) => setState(() {}),
                    );
                  },
                  child: Icon(Icons.shopping_cart)),
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text('DETAILS'),
      ),
      body: isLoadign
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.54,
                        height: MediaQuery.of(context).size.height * 0.3,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              '$productUrl${data.data?.image}',
                            ),
                            // image: AssetImage('$fishImage'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, top: 10),
                            child: Text('${data.data?.productName}',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, top: 10),
                            child: Text('${data.data?.shortDescription}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, top: 10),
                            child: Text('${data.data?.price}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, top: 12),
                    child: Text(
                      'Discription',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, top: 9),
                    child: Text(
                      '${data.data?.longDescription}',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  rowWidgetFour(name: 'Quantity'),
                  Center(
                      child: Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: appButtonBlacka(
                              function: () {
                                double qty = qtController.text.isEmpty
                                    ? 0
                                    : double.parse(qtController.text);
                                setState(() {
                                  if (qty == 0 || qty < 0) {
                                    toast('Please enter valid quantity');
                                  } else {
                                    bool present = false;
                                    for (var i = 0; i < hddb.length; i++) {
                                      if (data.data?.id ==
                                          hddb[i].values.first?.id) {
                                        present = true;
                                        break;
                                      }
                                    }
                                    if (present) {
                                      toast('Product is already added');
                                    } else {
                                      hddb.add({qty: data.data});
                                      toast('Product added succesfully');
                                    }
                                  }
                                });

                                print(hddb);
                              },
                              name: "Add to Cart",
                              context: context)))
                ],
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
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * .35,
                  height: MediaQuery.of(context).size.height * .05,
                  child: Center(
                      child: Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: qtController,
                      keyboardType: TextInputType.number,

                      // validator:  (text) {
                      //         if (!(text!.contains('@')) || text.isEmpty) {
                      //           return 'Enter a valid email address';
                      //         }
                      //         return null;
                      //       },

                      decoration: InputDecoration(
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  width: 0, style: BorderStyle.none)),
                          fillColor: Color(0xFFF2F2F2),
                          hintStyle: GoogleFonts.poppins(fontSize: 16.0),
                          hintText: "Qty",
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 24.0,
                            // vertical: 10.0,
                          )),
                    ),
                  )),
                ),
              ),
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
}

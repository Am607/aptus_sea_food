import 'package:aptusseafood/Controller/localdb.dart';
import 'package:aptusseafood/Controller/restApi.dart';
import 'package:aptusseafood/constants/constants.dart';
import 'package:aptusseafood/model/homeDelivery/category.dart';
import 'package:aptusseafood/view/homeDelivery/hdCart.dart';
import 'package:aptusseafood/view/homeDelivery/hdProductPage.dart';
import 'package:aptusseafood/view/signUp.dart';
import 'package:aptusseafood/widgets/CommonWidgets.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class HomeDeliveryPage extends StatefulWidget {
  const HomeDeliveryPage({ Key? key }) : super(key: key);

  @override
  _HomeDeliveryPageState createState() => _HomeDeliveryPageState();
}

class _HomeDeliveryPageState extends State<HomeDeliveryPage> {
   TextEditingController postCodeController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
         actions: [
          
              Container(
                    padding: EdgeInsets.only(top: 10, right: 10),
                    child: Badge(
                      badgeColor: Colors.blue,
                      shape: BadgeShape.circle,
                      toAnimate: false,
                      badgeContent: Text('${hddb.length}',
                          style: TextStyle(color: Colors.white)),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HdCartPage(),
                              ),
                            ).then((value) => 
                            setState((){}),
                            );
                          },
                          child: Icon(Icons.shopping_cart)),
                    ),
                  ),
               
            SizedBox(
              width: 10,
            ),
          ],
        elevation: 0,
        backgroundColor: Colors.black,
        title: const Text('PRODUCT CATALOG', style: TextStyle(fontSize: 18),),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.only(left: 40, right: 40),
            width: MediaQuery.of(context).size.width * .9,
            height: MediaQuery.of(context).size.height * .05,
            child: InputfieldA(
              onChangedFuntion: (value) {},
              icon: Icon(
                Icons.search,
                color: Colors.black,
                size: 20,
              ),
              isEmail: false,
              text: 'ENTER POSTCODE',
              controller: postCodeController,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          //  gridview

          //  CircleAvatar(
          //   backgroundImage: AssetImage('$fishIcon'),
          // ),

          Expanded(
            child: FutureBuilder<HomedeliveryCategry>(
              future: RsetAPi().hdCategory(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  // print('count here ${snapshot.data?.data?.length.toString()}');

                  return GridView.builder(
                      itemCount: snapshot.data?.data?.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        // crossAxisSpacing: 5.0,
                        // mainAxisSpacing: 5.0,
                      ),
                      itemBuilder: (context, index) {
                        return circleItem(context, snapshot.data?.data?[index]);
                      });
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget circleItem(BuildContext context,  Datum? data) { 
    return Container(
      height: MediaQuery.of(context).size.height * .25,
      child: Column(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductPage(id: data!.id.toString(),),
                  )
                ).then((value) =>  setState(() {}));
              },
              child: Container(
                margin: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                height: MediaQuery.of(context).size.width * .18,
                width: MediaQuery.of(context).size.width * .16,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(120),
                  border: Border.all(color: Colors.black),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(120),
                    color: Colors.white,
                    image: DecorationImage(
                      // image: AssetImage('$fishIcon'),
                      image: NetworkImage(
                        '$imageUrl${data?.categoryImage}',
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
              child: Text(
            '${data?.categoryName}',
            style: TextStyle(fontSize: 13),
          )),
        ],
      ),
    );
  }
}

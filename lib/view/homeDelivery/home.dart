import 'package:aptusseafood/Controller/restApi.dart';
import 'package:aptusseafood/constants/constants.dart';
import 'package:aptusseafood/model/homeDelivery/category.dart';
import 'package:aptusseafood/view/homeDelivery/hdProductPage.dart';
import 'package:aptusseafood/view/signUp.dart';
import 'package:aptusseafood/widgets/CommonWidgets.dart';
import 'package:flutter/material.dart';

class HomeDeliveryPage extends StatelessWidget {
  HomeDeliveryPage({Key? key}) : super(key: key);

  TextEditingController postCodeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.black,
        title: const Text('PRODUCT CATALOG'),
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
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              // crossAxisSpacing: 5.0,
                              // mainAxisSpacing: 5.0,
                            ),
                            itemBuilder: (context, index) {
                              return circleItem(context);
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

  Widget circleItem(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .26,
      child: Column(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductPage(),
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.only(left: 15, right: 15, bottom: 5),
                height: MediaQuery.of(context).size.width * .2,
                width: MediaQuery.of(context).size.width * .2,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  border: Border.all(color: Colors.black),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    color: Colors.white,
                    image: DecorationImage(
                      image: AssetImage('$fishIcon'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
              child: Text(
            'PRAWNS',
            style: TextStyle(fontSize: 13),
          )),
        ],
      ),
    );
  }
}

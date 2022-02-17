import 'package:aptusseafood/Controller/restApi.dart';
import 'package:aptusseafood/constants/constants.dart';
import 'package:aptusseafood/model/homeDelivery/hdproductModel.dart';
import 'package:aptusseafood/view/homeDelivery/hdDetails.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  final String id;
  const ProductPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: Colors.black,
          title: const Text('PRODUCTS'),
        ),
        body: FutureBuilder<Hdproduct>(
          future: RsetAPi().hdProducts(id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.done) {
              return snapshot.data?.data?.length == 0 ?
                Center(
                  child: Text("Oops No Product Found"),
                )
              
               :ListView.builder(
                
                // itemCount: 2,
                  itemCount: snapshot.data?.data?.length,
                  itemBuilder: (context, index) {
                    return rectangleItem(context , snapshot.data?.data?[index]);
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        )

        //  SingleChildScrollView(
        //   child: Column(
        //     children: <Widget>[
        //       rectangleItem(context),
        //       rectangleItem(context),
        //       rectangleItem(context),
        //       rectangleItem(context),
        //       rectangleItem(context),
        //     ],
        //   ),
        // ),
        );
  }

  Container rectangleItem(BuildContext context , Datum? data) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      height: MediaQuery.of(context).size.height * 0.18,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                        '$productUrl${data?.image}',
                      ),
                // image: AssetImage('$fishImage'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 4),
                  child: Text('${data?.productName}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 2),
                  child: Text('${data?.shortDescription}',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 2),
                  child: Text('${data?.price}',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(top: 6),
                  height: 1,
                  color: Colors.black,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 8),
                      child: Text(
                        'Learn More',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0, top: 8),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => HdDetails(id: data!.id.toString(),),
                            ),
                          );
                        },
                        child: Text(
                          'BUY',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

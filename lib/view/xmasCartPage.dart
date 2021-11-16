import 'package:aptusseafood/Controller/localdb.dart';
import 'package:flutter/material.dart';

class XmaxCartPage extends StatelessWidget {
  const XmaxCartPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.black,
        title: Text('Xmas Cart'),
      ),
      body:
      
      //list view Builder
   dbx.length == 0 ? Center(
     child: Text('Cart is Empty'),
   ) :  ListView.builder(
        itemCount: dbx.length,
        itemBuilder: (context, index) {
          return item(name: "${dbx[index]?.productName}", price:double.parse( dbx[index]!.price ), context: context, );
        },
      ),
    );



    
   
  }

item(
      {
      required String name,
      required double price,
    
      required BuildContext context,
   }) {
    return InkWell(
     
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
                color:  Colors.white,
              ),
            ),
            subtitle: Text(
              '\$$price',
              style: TextStyle(
                fontSize: 15,
                color:  Colors.white,
              ),
            ),
           
               
          ),
        ),
        decoration: BoxDecoration(
          color:  Colors.black,
          // borderRadius: BorderRadius.circular(12)
        ),
      ),
      // Divider(
      //   thickness: 1,
      //   color: Colors.black12,
      // )
    );
  }
  
}
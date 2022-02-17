import 'package:aptusseafood/Controller/localdb.dart';
import 'package:flutter/material.dart';

class HdCartPage extends StatefulWidget {
  const HdCartPage({Key? key}) : super(key: key);

  @override
  _HdCartPageState createState() => _HdCartPageState();
}

class _HdCartPageState extends State<HdCartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          elevation: 0,
          title: Text('Cart'),
        ),
        body: hddb.length == 0
            ? Center(
                child: Text('Cart is Empty'),
              )
            : ListView.builder(
                itemCount: hddb.length,
                itemBuilder: (context, index) {
                  return item(
                    qty: double.parse('${hddb[index].keys.first}'),
                    name: "${hddb[index].values.first?.productName}",
                    id: "${hddb[index].values.first?.id}",
                    price: double.parse(
                        hddb[index].values.first!.price.toString()),
                    context: context,
                  );
                },
              ));
  }

  item({
    required String id,
    required String name,
    required double price,
    required BuildContext context,
    required double qty,
  }) {
    var a = qty * price;

    double finalPrice = double.parse((a).toStringAsFixed(2));
    return InkWell(
      child: Container(
        height: MediaQuery.of(context).size.height * .12,
        padding: EdgeInsets.zero,
        margin: EdgeInsets.only(top: 3),
        child: Center(
          child: ListTile(
            title: Text(
              '$name',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.remove_shopping_cart,
                color: Colors.black,
              ),
              onPressed: () {
                hddb.removeWhere(
                    (element) => element.values.first?.id.toString() == id);
                setState(() {});
                print(hddb);
              },
            ),
            subtitle: Text(
              '\$$finalPrice',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: Colors.black12,
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:aptusseafood/Controller/restApi.dart';
import 'package:aptusseafood/constants/constants.dart';
import 'package:aptusseafood/model/planModel.dart';
import 'package:aptusseafood/view/productPage.dart';

import 'package:aptusseafood/widgets/CommonWidgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class PlanPage extends StatefulWidget {
  const PlanPage({Key? key}) : super(key: key);

  @override
  _PlanPageState createState() => _PlanPageState();
}

String indexA = '';

class _PlanPageState extends State<PlanPage> {
  List<String> plans = ['6am-7am', '7am-8am', '8am-9am'];
  late Future<Dats> data;

  String? value;
  String planName = '';

  @override
  void initState() {
    super.initState();
    int();
  }

  int() {
    data = RsetAPi().fetchPlan();
  }

  @override
  Widget build(BuildContext context) {
    print('buid widget');

   
    return Scaffold(body: body(context));
  }

  Container body(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          timeSlot(),
          SizedBox(
            height: 10,
          ),
          Container(
            height: MediaQuery.of(context).size.height * .7,
            child: FutureBuilder<Dats>(
                future: data,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print(snapshot.data!.data[2].planName);
                    return ListView.builder(
                        itemCount: snapshot.data!.data.length,
                        itemBuilder: (context, index) {
                          return itemCard(
                              name: snapshot.data!.data[index].planName,
                              id: snapshot.data!.data[index].id.toString(),
                              isSelcted: indexA,
                              function: () {
                                setState(() {
                                  indexA =
                                      snapshot.data!.data[index].id.toString();
                                  planName =
                                      snapshot.data!.data[index].planName;
                                });
                              });
                        });
                  } else if (snapshot.hasError) {
                    return Text('error');
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                appButtonTwo(
                    function: () {
                      Navigator.pop(context);
                    },
                    name: 'Back'),
                SizedBox(
                  width: 30,
                ),
                appButtonTwo(
                    function: () {
                      if (indexA == '') {
                        toast('Please Select One Plan');
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductPage(
                                      planName: planName,
                                      index: indexA,
                                    )));
                      }
                    },
                    name: 'Next')
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget itemCard(
      {required String name,
      required String id,
      required String isSelcted,
      required void Function() function}) {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 10),
      child: InkWell(
        onTap: function,
        child: Stack(
          children: [
            backround(isSelcted: isSelcted, name: name, id: id),
            Positioned(
              left: 50,
              bottom: 25,
              child: planeName(name: name),
            ),
            Positioned(
                left: 55,
                top: 15,
                child: Text(
                  'Plan details',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                )),
            Positioned(
              right: 45,
              bottom: 22,
              child: Center(
                child: Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage(appIocon))),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container planeName({required String name}) {
    return Container(
      width: 180,
      height: 40,
      child: Container(
        padding: EdgeInsets.only(left: 12, top: 10),
        child: Text(
          name,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
    );
  }

  Container backround(
      {required String isSelcted, required String name, required String id}) {
    return Container(
      margin: EdgeInsets.only(right: 26, left: 26, top: 2, bottom: 2),
      height: 110,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isSelcted == id ? Color(0xFF5EC401) : Color(0xFFDEDEDE)),
    );
  }

  Container timeSlot() {
    return Container(
        height: 45,
        width: 400,
        margin: EdgeInsets.only(left: 26, right: 26),
        padding: EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: Color(greyColor)),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            iconSize: 30,
            items: plans.map(buildmenuItem).toList(),
            icon: Icon(
              Icons.arrow_drop_down,
              color: Colors.black,
            ),
            value: value == null ? plans[0] : value,
            onChanged: (value) => setState(() => this.value = value!),
          ),
        ));
  }

  DropdownMenuItem<String> buildmenuItem(String item) => DropdownMenuItem(
        child: Text(item),
        value: item,
      );
}

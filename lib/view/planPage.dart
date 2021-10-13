import 'package:aptusseafood/Controller/localdb.dart';
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
  List<String> plans = ['Choose a Time Slot'];
  List<String> dates = ['Choose a Delivery Date', "23-12-2021", "24-12-2021"];
  late Future<Plan> data;

  String? valuea;
  String? valueb;
  String planName = '';

  @override
  void initState() {
    super.initState();
    int();
  }

  int() async {
    data = RsetAPi().fetchPlan().then((value) {
      List<Datum>? dat = value.timeSlotes;

      for (dynamic a = 0; a < value.timeSlotes?.length; a++) {
        setState(() {
          plans.add('${dat?[a].timeSlot}');
        });

        print('called');
        print(plans);
      }

      return value;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('buid widget id 320');
    print(valuea);

    return Scaffold(
      body: body(context),
      bottomNavigationBar: navigationBar(
          context: context,
          backname: 'Back',
          next: () {
            if (indexA == '') {
              toast('Please Select One Plan');
            } else if (valuea == null || valuea == 'Choose a Time Slot') {
              toast('Please Select Time Slot');
            } else if (valueb == null || valueb == 'Choose a Delivery Date') {
              toast('Please Select a Delivery Date');
            } else {
              int() {
                print(db);
                db.clear();
                print(db);
                dbx.clear();
                dby.clear();
                print(dby);
                print(dbx);
              }

              int();

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductPage(
                            date: "$valueb",
                            planName: planName,
                            index: indexA,
                            timeSlote: "$valuea",
                          )));
            }
          },
          nextName: 'Next',
          back: () {
            Navigator.pop(context);
          }),
    );
  }

  body(BuildContext context) {
    return ListView(
      children: [
        imageAppBar('', context),
        // Padding(
        //   padding: const EdgeInsets.only(top: 8),
        //   child: Center(
        //       child: Text(
        //     'Plan Details',
        //     style: TextStyle(
        //         fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
        //   )),
        // ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .04,
        ),
        timeSlot(),
        SizedBox(
          height: MediaQuery.of(context).size.height * .02,
        ),
        dateSlot(),
        SizedBox(
          height: MediaQuery.of(context).size.height * .01,
        ),
        Center(
            child: Text(
          'Browse by category in',
          style: TextStyle(
              fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
        )),
        FutureBuilder<Plan>(
            future: data,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // print(snapshot.data?.data?[2].planName);
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data?.data?.length,
                    itemBuilder: (context, index) {
                      final data = snapshot.data?.timeSlotes?[index].timeSlot;

                      // plans.add(data!);

                      return itemCard(
                          name: '${snapshot.data!.data![index].planName}',
                          id: snapshot.data!.data![index].id.toString(),
                          isSelcted: indexA,
                          function: () {
                            setState(() {
                              indexA =
                                  snapshot.data!.data![index].id.toString();
                              planName = snapshot.data!.data![index].planName!;
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
      ],
    );
  }

  Widget itemCard(
      {required String name,
      required String id,
      required String isSelcted,
      required void Function() function}) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child: InkWell(
        onTap: function,
        child: backround(isSelcted: isSelcted, name: name, id: id),
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

  Container backround({
    required String isSelcted,
    required String name,
    required String id,
  }) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 40),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "$name Plan",
            style: TextStyle(
                fontSize: 17,
                color: isSelcted == id ? Colors.white : Colors.black),
          ),
        ),
      ),
      margin: EdgeInsets.only(right: 18, left: 18, top: 0, bottom: 0),
      height: MediaQuery.of(context).size.height * .06,
      width: MediaQuery.of(context).size.width * .9,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(30),
          color: isSelcted == id ? Colors.black : Colors.white),
    );
  }

  Container timeSlot() {
    return Container(
        height: MediaQuery.of(context).size.height * .065,
        // width: MediaQuery.of(context).size.width * .5,
        margin: EdgeInsets.only(left: 18, right: 18),
        padding: EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(12),
            color: Colors.white),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            iconSize: 30,
            items: plans.map(buildmenuItem).toList(),
            icon: Icon(
              Icons.arrow_drop_down,
              color: Colors.black,
            ),
            value: valuea == null ? plans[0] : valuea,
            onChanged: (value) => setState(() => this.valuea = value),
          ),
        ));
  }

  Container dateSlot() {
    return Container(
        height: MediaQuery.of(context).size.height * .065,
        // width: MediaQuery.of(context).size.width * .5,
        margin: EdgeInsets.only(left: 18, right: 18),
        padding: EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(12),
            color: Colors.white),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            iconSize: 30,
            items: dates.map(buildmenuItem).toList(),
            icon: Icon(
              Icons.arrow_drop_down,
              color: Colors.black,
            ),
            value: valueb == null ? dates[0] : valueb,
            onChanged: (value) => setState(() => this.valueb = value),
          ),
        ));
  }

  DropdownMenuItem<String> buildmenuItem(String item) {
    // setState(() {});
    return DropdownMenuItem(
      child: Text(item),
      value: item,
    );
  }
}

Container imageAppBar(String title, BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height * .3,
    decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(seafood), fit: BoxFit.cover)),
    child: Align(
      alignment: Alignment.center,
      child: Text(
        '$title',
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    ),
  );
}

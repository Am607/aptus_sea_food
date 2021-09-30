import 'package:flutter/material.dart';

class StripPage extends StatefulWidget {
  const StripPage({Key? key}) : super(key: key);

  @override
  _StripPageState createState() => _StripPageState();
}

class _StripPageState extends State<StripPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
            child: ElevatedButton(
          child: Text("Pay"),
          onPressed: () {},
        )),
      ),
    );
  }
}

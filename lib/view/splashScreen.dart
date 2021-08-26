import 'package:flutter/material.dart';


//! this ui is not using currently may be need later

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Image.asset('asset/pic.png'),
        ),
      ),
    );
  }
}

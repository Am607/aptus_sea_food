import 'package:aptusseafood/view/HomePageOption.dart';
import 'package:aptusseafood/view/logiinScreen.dart';
import 'package:aptusseafood/widgets/CommonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white30,
        iconTheme: IconThemeData(color: Colors.blue),
        elevation: 00,
        actions: [
          Center(
            child: Text(
              '20-May-2021',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
          SizedBox(
            width: 25,
          ),
        ],
      ),
      body: ListView(children: [
        Container(
          padding: EdgeInsets.only(left: 26, right: 26, top: 1),
          child: Column(
            children: [
              Inputfield(text: 'Enter Name', icon: Icon(Icons.person)),
              SizedBox(
                height: 16.0,
              ),
              Inputfield(
                text: 'Enter Email Id',
                icon: Icon(Icons.email),
              ),
              SizedBox(
                height: 16.0,
              ),
              Inputfield(
                text: 'Enter Phone Number',
                icon: Icon(Icons.phone),
              ),
              SizedBox(
                height: 16.0,
              ),
              Inputfield(
                text: 'Unit/Street Name',
                icon: Icon(Icons.home),
              ),
              SizedBox(
                height: 16.0,
              ),
              Row(
                children: [
                  Expanded(
                      child: Inputfield(
                          icon: Icon(Icons.calculate), text: 'Suburb')),
                  SizedBox(
                    width: 16.0,
                  ),
                  Expanded(
                      child:
                          Inputfield(icon: Icon(Icons.calculate), text: 'Pin')),
                ],
              ),
              SizedBox(
                height: 16.0,
              ),
              Container(
                padding: EdgeInsets.only(right: 160.0),
                child: Inputfield(
                    icon: Icon(Icons.maps_home_work_sharp), text: 'State'),
              ),
              SizedBox(
                height: 16.0,
              ),
              Inputfield(
                  icon: Icon(Icons.location_on), text: 'Pickup Location'),
              SizedBox(
                height: 16.0,
              ),
            ],
          ),
        ),
        appButton(
            function: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => HomePageOption())),
            name: "Login"),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 26.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Text(
                    'Have a account?   Login',
                    style: TextStyle(
                      color: Colors.blueAccent,
                    ),
                  )),
            ],
          ),
        ),
      ]),
    ));
  }
}

class Inputfield extends StatelessWidget {
  final String text;
  final Icon? icon;
  final TextInputType? keyboardType;
  Inputfield({this.icon, required this.text , this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      child: TextField(
     keyboardType: keyboardType,
        decoration: InputDecoration(
        
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(width: 0, style: BorderStyle.none)),
            fillColor: Color(0xFFF2F2F2),
            hintStyle: GoogleFonts.poppins(fontSize: 16.0),
            prefixIcon: icon,
            hintText: text,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 18.0,
            )),
      ),
    );
  }
}

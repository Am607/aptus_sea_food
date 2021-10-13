import 'package:aptusseafood/Controller/authApi.dart';
import 'package:aptusseafood/view/HomePageOption.dart';

import 'package:aptusseafood/widgets/CommonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController nameCoun = TextEditingController();
  final TextEditingController emailCount = TextEditingController();
  final TextEditingController phoneCount = TextEditingController();
  final TextEditingController unitCount = TextEditingController();
  final TextEditingController suburbCount = TextEditingController();
  final TextEditingController pinCount = TextEditingController();
  final TextEditingController stateCount = TextEditingController();
  final TextEditingController textEditingController = TextEditingController();

  GlobalKey<FormState> _form = GlobalKey<FormState>(); // for storing form state

  bool isLoading = false;
  DateTime now = new DateTime.now();

  @override
  Widget build(BuildContext context) {
    var formatter = new DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(now);
    void _saveForm(BuildContext context) {
      final isValid = _form.currentState!.validate();
      if (!isValid) {
        return;
      } else {
        setState(() {
          isLoading = true;
        });

        AuthApi authApi = AuthApi();
        authApi
            .signup(
          street: unitCount.text,
          name: nameCoun.text,
          password: '12',
          email: emailCount.text,
          mobile: phoneCount.text,
          suburb: suburbCount.text,
          pincode: pinCount.text,
          state: stateCount.text,
        )
            .then((value) async {
          if (value.status == true) {
            final storage = new FlutterSecureStorage();
            await storage.write(key: 'token', value: value.token.toString());
            toast('Signup success');
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => HomePageOption()));
          } else if (value.message == 'The email has already been taken') {
            setState(() {
              isLoading = false;
            });

            toast('The email is alredy used');
          } else {
            setState(() {
              isLoading = false;
            });

            toast('Somthing went wrong');
          }
        });
      }
    }

    setState(() {});
    return SafeArea(
        child: Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white30,
      //   iconTheme: IconThemeData(color: Colors.blue),
      //   elevation: 00,
      //   actions: [
      //     Center(
      //       child: Text(
      //         '$formattedDate',
      //         style: TextStyle(color: Colors.blue, fontSize: 16),
      //       ),
      //     ),
      //     SizedBox(
      //       width: 25,
      //     ),
      //   ],
      // ),
      body: isLoading ? loading() : body(_saveForm, context),
    ));
  }

  Widget loading() => Center(
        child: CircularProgressIndicator(),
      );

  Form body(void _saveForm(BuildContext contet), BuildContext context) {
    return Form(
      key: _form,
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            child: Image(
                // color: Colors.blue,
                // height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
                image: AssetImage('assets/a.jpg')),
          ),
          ListView(children: [
            Container(
              padding: EdgeInsets.only(left: 40, right: 40, top: 4),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .03,
                  ),
                  login(context),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .03,
                  ),
                  Inputfield(
                    text: 'Enter Name',
                    icon: Icon(Icons.person),
                    controller: nameCoun,
                    isEmail: false,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .03,
                  ),
                  Inputfield(
                    text: 'Enter Email Id',
                    icon: Icon(Icons.email),
                    controller: emailCount,
                    value: emailCount.text,
                    isEmail: true,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .03,
                  ),
                  Inputfield(
                    isEmail: false,
                    keyboardType: TextInputType.phone,
                    text: 'Enter Phone Number',
                    icon: Icon(Icons.phone),
                    controller: phoneCount,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .03,
                  ),
                  Inputfield(
                    isEmail: false,
                    text: 'Unit/Street Name',
                    icon: Icon(Icons.home),
                    controller: unitCount,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .03,
                  ),

                  Inputfield(
                      isEmail: false,
                      icon: Icon(Icons.place),
                      controller: suburbCount,
                      text: 'Suburb'),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .03,
                  ),
                  Inputfield(
                      keyboardType: TextInputType.number,
                      isEmail: false,
                      icon: Icon(Icons.pin),
                      controller: pinCount,
                      text: 'Pin'),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .03,
                  ),

                  Inputfield(
                    isEmail: false,
                    icon: Icon(Icons.maps_home_work_sharp),
                    text: 'State',
                    controller: stateCount,
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * .03,
                  ),
                  // Inputfield(
                  //   isEmail: false,
                  //   icon: Icon(Icons.location_on),
                  //   text: 'Pickup Location',
                  //   controller: pickupCount,
                  // ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .03,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              height: 45,
              child: appButtonBlack(
                  function: () {
                    _saveForm(context);
                  },

                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => HomePageOption())

                  // ),
                  name: "Signup",
                  context: context),
            ),
          ]),
        ],
      ),
    );
  }

  Padding login(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 6.0),
        child: Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: MediaQuery.of(context).size.width * .18,
                height: MediaQuery.of(context).size.height * .05,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.black,
                ),
                child: Center(
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              )),
        ));
  }
}

class Inputfield extends StatelessWidget {
  final String text;
  final Icon? icon;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? value;
  final bool isEmail;
  final ValueChanged<String>? onChangedFuntion;
  Inputfield(
      {this.icon,
      required this.text,
      this.keyboardType,
      this.controller,
      required this.isEmail,
      this.onChangedFuntion,
      this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .06,
      child: TextFormField(
        onChanged: onChangedFuntion,
        keyboardType: keyboardType,
        controller: controller,
        validator: isEmail
            ? (text) {
                if (!(text!.contains('@')) || text.isEmpty) {
                  return 'Enter a valid email address';
                }
                return null;
              }
            : (tex) {
                if (tex!.isEmpty) {
                  return "Enter valid $text";
                }
                return null;
              },
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
              // vertical: 10.0,
            )),
      ),
    );
  }
}

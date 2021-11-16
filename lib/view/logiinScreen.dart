import 'package:aptusseafood/Controller/authApi.dart';
import 'package:aptusseafood/constants/constants.dart';
import 'package:aptusseafood/view/HomePageOption.dart';
import 'package:aptusseafood/view/signUp.dart';

import 'package:aptusseafood/widgets/CommonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}
//! for textvisible functionality

bool _passwordVisible = true;
TextEditingController passwordController = TextEditingController();
TextEditingController userNameController = TextEditingController();
GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;

  // @override
  // void dispose() {
  //   passwordController.dispose();
  //   userNameController.dispose();

  //   super.dispose();
  // }
  bool validate = true;
  @override
  Widget build(BuildContext context) {
    save() {
      final isValid = _formKey1.currentState?.validate();
      if (isValid!) {
        validate = true;
        setState(() {
          isLoading = true;
        });

        AuthApi authApi = AuthApi();
        authApi
            .login(
                email: userNameController.text,
                password: passwordController.text)
            .then((value) async {
          userNameController.clear();
          passwordController.clear();
          print(value.status);
          if (value.status == true) {
            toast('successfully loged in');
            //! adding token
            final storage = new FlutterSecureStorage();
            await storage.write(key: 'token', value: value.token.toString());
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => HomePageOption()));
          } else {
            setState(() {
              isLoading = false;
              validate = true;
            });

            toast('Please enter valid email or password');
          }
        });
      }
      setState(() {
        validate = false;
      });
      return;
    }

    return SafeArea(
      child: Scaffold(
        body: isLoading == true ? loading() : body(save, context),
      ),
    );
  }

  Widget loading() => Center(
        child: CircularProgressIndicator(),
      );

  Form body(Null save(), BuildContext context) {
    return Form(
      key: _formKey1,
      child: Container(
        child: ListView(
          children: [
            Stack(
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

                Positioned(
                  top: MediaQuery.of(context).size.height * .1,
                  right: MediaQuery.of(context).size.width * .005,
                  child: signup(context),
                ),
                // Opacity(
                //   opacity: .7,
                //   child: ClipRRect(
                //     borderRadius: BorderRadius.only(
                //         bottomLeft: Radius.circular(20),
                //         bottomRight: Radius.circular(20)),
                //     child: Container(
                //       color: Colors.blue[500],
                //       height: MediaQuery.of(context).size.height * .46,
                //     ),
                //   ),
                // ),
                Positioned(
                  left: MediaQuery.of(context).size.width * .105,
                  top: MediaQuery.of(context).size.height * .2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: Container(
                      height: 100,
                      width: 100,
                      child: Image(
                        image: AssetImage(appIocon1),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width * .39,
                  top: MediaQuery.of(context).size.height * .24,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Row(
                            children: [
                              Text(
                                'MELBOURNE',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                              Text(
                                ' SEAFOOD',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          Text(
                            'Specialist Since 1969',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Positioned(
                  left: 0,
                  right: 0,
                  top: MediaQuery.of(context).size.height * .47,
                  child: Container(
                    margin: EdgeInsets.only(left: 40, right: 40),
                    // width: MediaQuery.of(context).size.width * .9,
                    height: validate
                        ? MediaQuery.of(context).size.height * .05
                        : MediaQuery.of(context).size.height * .08,
                    child: textField(
                      controller: userNameController,
                      ispassworrd: false,
                      name: 'User Name',
                      prefIcon: Icon(
                        Icons.person,
                        color: Colors.grey,
                        size: 16,
                      ),
                    ),
                  ),
                ),

                Positioned(
                  left: 0,
                  right: 0,
                  top: MediaQuery.of(context).size.height * .57,
                  child: Container(
                    margin: EdgeInsets.only(left: 40, right: 40),
                    width: MediaQuery.of(context).size.width * .9,
                    height: validate
                        ? MediaQuery.of(context).size.height * .05
                        : MediaQuery.of(context).size.height * .08,
                    child: textField(
                      controller: passwordController,
                      ispassworrd: true,
                      name: 'Password',
                      prefIcon: Icon(
                        Icons.lock,
                        color: Colors.grey,
                        size: 16,
                      ),
                    ),
                  ),
                ),

                Positioned(
                  top: MediaQuery.of(context).size.height * .68,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    height: 40,
                    child: appButtonBlacka(
                        context: context,
                        function: () {
                          save();
                        },
                        name: "Login"),
                  ),
                ),

                Positioned(
                  top: MediaQuery.of(context).size.height * .73,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 47, right: 47, top: 40),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 50,
                            width: 80,
                            child: Image(
                              fit: BoxFit.fill,
                              image: AssetImage('assets/grill.png'),
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 80,
                            child: Image(
                              fit: BoxFit.fill,
                              image: AssetImage('assets/oyster.png'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  //! widgets need this page only

  Padding signup(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 6.0),
        child: Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpPage()));
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
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              )),
        ));
  }

  Padding forgetPassword() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () {
              print('forget password ?');
            },
            child: Text(
              'Forget Password ?',
              style: TextStyle(
                fontSize: 14,
                color: Color(forgetColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget textField({
    required String name,
    // required Function function,
    required bool ispassworrd,
    required final controller,
    required Icon prefIcon,
    String? isOk,
  }) {
    return Container(
      // height: MediaQuery.of(context).size.height * .05,
      // width: MediaQuery.of(context).size.width,
      child: Center(
        child: TextFormField(
          // textAlignVertical: TextAlignVertical.center,
          onTap: () {
            setState(() {});
          },
          // textAlign: TextAlign.center,
          obscureText: ispassworrd ? !_passwordVisible : false,
          controller: controller,
          validator: (isOk) {
            if (isOk!.isEmpty) {
              return 'This field is required';
            }
            return null;
          },
          decoration: InputDecoration(
            // isCollapsed: true, //! for icon
            errorStyle: TextStyle(fontSize: 12),
            filled: true,
            // fillColor: Color(0xFFF0F1F2),
            focusedBorder: OutlineInputBorder(
                gapPadding: 20,
                borderRadius: BorderRadius.circular(1),
                borderSide: BorderSide(
                    width: 2, style: BorderStyle.solid, color: Colors.grey)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(1),
                borderSide: BorderSide(
                    width: 2, style: BorderStyle.solid, color: Colors.grey)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(1),
                borderSide: BorderSide(
                    width: 2, style: BorderStyle.solid, color: Colors.grey)),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(1),
                borderSide: BorderSide(
                    width: 2, style: BorderStyle.solid, color: Colors.grey)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(1),
                borderSide: BorderSide(
                    width: 2, style: BorderStyle.solid, color: Colors.grey)),
            prefixIcon: prefIcon,

            hintText: name,
            hintStyle: regularheading,

            // suffixIcon: ispassworrd
            //     ? IconButton(
            //         icon: Icon(
            //           _passwordVisible
            //               ? Icons.visibility
            //               : Icons.visibility_off,
            //         ),
            //         onPressed: () {
            //           setState(() {
            //             _passwordVisible = !_passwordVisible;
            //           });
            //         },
            //       )
            //     : null,
            contentPadding: EdgeInsets.all(9),

            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(1),
                borderSide: BorderSide(
                    width: 2, style: BorderStyle.solid, color: Colors.grey)),
          ),
        ),
      ),
    );
  }
}

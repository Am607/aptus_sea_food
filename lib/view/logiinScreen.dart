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

  @override
  Widget build(BuildContext context) {
    save() {
      final isValid = _formKey1.currentState?.validate();
      if (isValid!) {
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
            });

            toast('Please enter valid email or password');
          }
        });
      }
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
                  left: MediaQuery.of(context).size.width * .15,
                  top: MediaQuery.of(context).size.height * .2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: Container(
                      height: 80,
                      width: 80,
                      child: Image(
                        image: AssetImage(appIocon1),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width * .4,
                  top: MediaQuery.of(context).size.height * .225,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          // Text(
                          //   'MELBOURNE SEAFOOD',
                          //   style: TextStyle(
                          //       fontWeight: FontWeight.w600,
                          //       foreground: Paint()
                          //         ..style = PaintingStyle.stroke
                          //         ..strokeWidth = 3
                          //         ..color = Colors.white,
                          //       fontSize: 18),
                          // ),
                          Row(
                            children: [
                              Text(
                                'MELBOURNE',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18),
                              ),
                              Text(
                                ' SEAFOOD',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          // Text(
                          //   'Specialist Since 1969',
                          //   style: TextStyle(
                          //       fontWeight: FontWeight.w600,
                          //       foreground: Paint()
                          //         ..style = PaintingStyle.stroke
                          //         ..strokeWidth = 3
                          //         ..color = Colors.white,
                          //       fontSize: 17),
                          // ),
                          Text(
                            'Specialist Since 1969',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 17),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Positioned(
                  left: MediaQuery.of(context).size.width * .05,
                  top: MediaQuery.of(context).size.height * .47,
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * .9,
                      height: MediaQuery.of(context).size.height * .067,
                      child: Center(
                        child: textField(
                          controller: userNameController,
                          ispassworrd: false,
                          name: 'User Name',
                          prefIcon: Icon(Icons.person),
                        ),
                      ),
                    ),
                  ),
                ),

                Positioned(
                  left: MediaQuery.of(context).size.width * .05,
                  top: MediaQuery.of(context).size.height * .57,
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * .9,
                      height: MediaQuery.of(context).size.height * .067,
                      child: textField(
                        controller: passwordController,
                        ispassworrd: true,
                        name: 'Password',
                        prefIcon: Icon(Icons.lock),
                      ),
                    ),
                  ),
                ),

                Positioned(
                  top: MediaQuery.of(context).size.height * .68,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.only(left: 18, right: 18),
                    height: 42,
                    child: appButtonBlack(
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
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 2),
      child: Container(
        // height: MediaQuery.of(context).size.height * .02,
        child: Center(
          child: TextFormField(
            textAlign: TextAlign.start,
            obscureText: ispassworrd ? !_passwordVisible : false,
            controller: controller,
            validator: (isOk) {
              if (isOk!.isEmpty) {
                return 'This field is required';
              }
              return null;
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Color(0xFFF0F1F2),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(width: 0, style: BorderStyle.none)),
              prefixIcon: prefIcon,
              hintText: name,
              hintStyle: regularheading,
              suffixIcon: ispassworrd
                  ? IconButton(
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    )
                  : null,
              contentPadding: EdgeInsets.all(0),
            ),
          ),
        ),
      ),
    );
  }
}

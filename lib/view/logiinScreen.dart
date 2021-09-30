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
            toast('login success');
            //! adding token
            final storage = new FlutterSecureStorage();
            await storage.write(key: 'token', value: value.token.toString());
            Navigator.push(context,
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
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
            Stack(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    child: Container(
                      height: MediaQuery.of(context).size.height * .46,
                      // decoration: BoxDecoration(
                      //     image: DecorationImage(
                      //   fit: BoxFit.cover,
                      //   colorFilter: ColorFilter.mode(
                      //       Colors.blue.withOpacity(.3), BlendMode.dstATop),
                      //   image: AssetImage('assets/a.jpg'),
                      // )),
                      child: Image(
                          // color: Colors.blue,
                          height: MediaQuery.of(context).size.height * .46,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                          image: AssetImage('assets/a.jpg')),
                    )),
                Opacity(
                  opacity: .7,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    child: Container(
                      color: Colors.blue[500],
                      height: MediaQuery.of(context).size.height * .46,
                    ),
                  ),
                ),
                Positioned(
                  left: 8,
                  top: 6,
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
                  left: 95,
                  top: 25,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Text(
                            'MELBOURNE SEAFOOD',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 6
                                  ..color = Colors.white,
                                fontSize: 18),
                          ),
                          Text(
                            'MELBOURNE SEAFOOD',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 18),
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          Text(
                            'Specialist Since 1969',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 6
                                  ..color = Colors.white,
                                fontSize: 17),
                          ),
                          Text(
                            'Specialist Since 1969',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 17),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),

            // headingSection(),
            SizedBox(
              height: 6,
            ),
            Container(
              child: textField(
                controller: userNameController,
                ispassworrd: false,
                name: 'UserName',
                prefIcon: Icon(Icons.person),
              ),
            ),
            textField(
              controller: passwordController,
              ispassworrd: true,
              name: 'Password',
              prefIcon: Icon(Icons.lock),
            ),
            // forgetPassword(),
            SizedBox(
              height: 3,
            ),
            appButton(
                function: () {
                  save();
                },
                name: "Login"),
            signup(context),
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    child: Image(
                      image: AssetImage('assets/grill.png'),
                    ),
                  ),
                  Container(
                    height: 80,
                    width: 80,
                    child: Image(
                      image: AssetImage('assets/Oyster.jpg'),
                    ),
                  ),
                ],
              ),
            )
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
              child: Text(
                'New User?  Sign Up',
                style: TextStyle(
                  color: Colors.blueAccent,
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

  Padding textField({
    required String name,
    // required Function function,
    required bool ispassworrd,
    required final controller,
    required Icon prefIcon,
    String? isOk,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 5, top: 5),
      child: Container(
        height: MediaQuery.of(context).size.height * .08,
        child: TextFormField(
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
              contentPadding: EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 18.0,
              )),
        ),
      ),
    );
  }
}

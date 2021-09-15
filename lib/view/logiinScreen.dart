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

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    print('build');
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            headingSection(),
            SizedBox(
              height: 60,
            ),
            textField(
              controller: userNameController,
              ispassworrd: false,
              name: 'UserName',
              prefIcon: Icon(Icons.person),
            ),
            textField(
              controller: passwordController,
              ispassworrd: true,
              name: 'Password',
              prefIcon: Icon(Icons.lock),
            ),
            forgetPassword(),
            SizedBox(
              height: 30,
            ),
            appButton(
                function: () {
                  AuthApi authApi = AuthApi();
                  authApi
                      .login(
                          email: userNameController.text,
                          password: passwordController.text)
                      .then((value) async {
                    print(value.status);
                    if (value.status == true) {
                      toast('login success');
                      //! adding token
                      final storage = new FlutterSecureStorage();
                      await storage.write(
                          key: 'token', value: value.token.toString());
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePageOption()));
                    } else {
                      toast('Please enter valid email or password');
                    }
                  });
                },

                //  (

                // ) => Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => HomePageOption())),
                name: "Login"),
            signup(context),
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
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 12, top: 12),
      child: TextField(
        obscureText: ispassworrd ? !_passwordVisible : false,
        controller: controller,
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
    );
  }
}

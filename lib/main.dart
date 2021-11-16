import 'package:aptusseafood/view/logiinScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // set the publishable key for Stripe - this is mandatory
  Stripe.publishableKey =
      'pk_test_51JZlPfBwHjZQ9ZBhCGd0DAqmgHMbaOhJxx8pXWspOUmkXtqflnyzjFPKkbh7xhAvRxBhKGvKqjW0UxvtmojsSIlH00Per1m0yf';

  runApp(MyApp());
}

// import io.flutter.embedding.android.FlutterFragmentActivity
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

// class LoginSplash extends StatefulWidget {
//   const LoginSplash({Key? key}) : super(key: key);

//   @override
//   _LoginSplashState createState() => _LoginSplashState();
// }

// class _LoginSplashState extends State<LoginSplash> {
//   @override
//   void initState() {
//     super.initState();
//     init();
//   }

//   init() async {

//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: CircularProgressIndicator(),
//       ),
//     );
//   }
// }
//  raz@gmail.com  12345678  AP10014 a@gmail.com
import 'package:aptusseafood/view/logiinScreen.dart';
import 'package:aptusseafood/view/notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // set the publishable key for Stripe - this is mandatory
  Stripe.publishableKey =
      'pk_test_51JZlPfBwHjZQ9ZBhCGd0DAqmgHMbaOhJxx8pXWspOUmkXtqflnyzjFPKkbh7xhAvRxBhKGvKqjW0UxvtmojsSIlH00Per1m0yf';

  runApp(A());
}

class A extends StatelessWidget {
  const A({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: MyApp());
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlatformState();
  }

  static final String oneSignalAppId = "739ac283-1b14-4cce-9b0e-eb2bda3e1773";

  Future<void> initPlatformState() async {
    OneSignal.shared.setAppId(oneSignalAppId);

    OneSignal.shared.setNotificationOpenedHandler(
        (OSNotificationOpenedResult result) async {
      // Will be called whenever a notification is opened/button pressed.
      print('navigation');
      print('${result.notification.subtitle.toString()}');
      //navigation
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NotificationPage(
            title: '${result.notification.title}',
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      // home: NotificationPage(
      //   title: 'll',
      // ),
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
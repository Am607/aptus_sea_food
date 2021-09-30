// import 'package:aptusseafood/view/bulkOrder/conformationPage.dart';
// import 'package:flutter/material.dart';
// import 'package:stripe_payment/stripe_payment.dart';

// class PaymentPage extends StatefulWidget {
//   const PaymentPage({Key? key}) : super(key: key);

//   @override
//   _PaymentPageState createState() => _PaymentPageState();
// }

// class _PaymentPageState extends State<PaymentPage> {
//   GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
//   @override
//   initState() {
//     super.initState();
//     StripePayment.setOptions(StripeOptions(
//       publishableKey:
//           "pk_test_51JfPscSJq6xO3Mt6uViE2n4zhx5ADWcPOtklEsa0NYyHqvG3srn4n8S6OpEAawPguWHamXTZiI6o2bAvsw9Hlrwu00aXjMcxjI",
//       merchantId: "test",
//       androidPayMode: 'test',
//     ));
//   }

//   late Source source;
//   late String error;
//   late PaymentMethod _paymentMethod;
//   late PaymentIntentResult _paymentIntent;
//   final String _currentSecret =
//       "sk_test_51JfPscSJq6xO3Mt6AED8Ov9sw0w9ptx4i8VFHuKtqkgrhAfF1NVAQ9dkBJcYMYNYhGSgK1jOdtUicWF36awMSXGi00n3CRK2QQ";
//   late Token _paymentToken;
//   void setError(dynamic error) {
//     _scaffoldKey.currentState
//         ?.showSnackBar(SnackBar(content: Text(error.toString())));
//     setState(() {
//       error = error.toString();
//     });
//   }

//   final CreditCard testCard = CreditCard(
//     number: '4111111111111111',
//     expMonth: 08,
//     expYear: 22,
//   );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: AppBar(
//         iconTheme: IconThemeData(color: Colors.blue),
//         elevation: 0,
//         backgroundColor: Colors.white30,
//         title: InkWell(
//           onTap: () {},
//           child: Text(
//             'Stripe PaymentPage',
//             style: TextStyle(color: Colors.black, fontSize: 18),
//           ),
//         ),
//       ),
//       body: Container(
//         child: ListView(
//           children: [
//             Center(
//               child: TextButton(
//                 child: Text('Continue'),
//                 onPressed: () {
//                   StripePayment.createSourceWithParams(SourceParams(
//                     type: 'ideal',
//                     amount: 4,
//                     currency: 'usd',
//                     returnURL: 'example://stripe-redirect',
//                   )).then((source) {
//                     _scaffoldKey.currentState?.showSnackBar(
//                         SnackBar(content: Text('Received ${source.sourceId}')));
//                     setState(() {
//                       source = source;
//                     });
//                   }).catchError(setError);

//                   // Navigator.pushReplacement(context,
//                   //     MaterialPageRoute(builder: (context) => ConfirmPage()));
//                 },
//               ),
//             ),
//             Center(
//               child: TextButton(
//                 child: Text("Create Token with Card Form"),
//                 onPressed: () {
//                   StripePayment.paymentRequestWithCardForm(
//                           CardFormPaymentRequest())
//                       .then((paymentMethod) {
//                     _scaffoldKey.currentState?.showSnackBar(SnackBar(
//                         content: Text('Received ${paymentMethod.id}')));
//                     setState(() {
//                       _paymentMethod = paymentMethod;
//                     });
//                   }).catchError(setError);
//                 },

//                 // Navigator.pushReplacement(context,
//                 //     MaterialPageRoute(builder: (context) => ConfirmPage()));
//               ),
//             ),
//             RaisedButton(
//               child: Text("Create Token with Card"),
//               onPressed: () {
//                 StripePayment.createTokenWithCard(
//                   testCard,
//                 ).then((token) {
//                   _scaffoldKey.currentState?.showSnackBar(
//                       SnackBar(content: Text('Received ${token.tokenId}')));
//                   setState(() {
//                     _paymentToken = token;
//                   });
//                 }).catchError(setError);
//               },
//             ),
//             Center(
//               child: TextButton(
//                 child: Text("Create Payment Method with Card"),
//                 onPressed: () {
//                   StripePayment.createPaymentMethod(
//                     PaymentMethodRequest(
//                       card: testCard,
//                     ),
//                   ).then((paymentMethod) {
//                     _scaffoldKey.currentState?.showSnackBar(SnackBar(
//                         content: Text('Received ${paymentMethod.id}')));
//                     setState(() {
//                       _paymentMethod = paymentMethod;
//                     });
//                   }).catchError(setError);
//                 },

//                 // Navigator.pushReplacement(context,
//                 //     MaterialPageRoute(builder: (context) => ConfirmPage()));
//               ),
//             ),
//             RaisedButton(
//               child: Text("Confirm Payment Intent"),
//               onPressed: _paymentMethod == null || _currentSecret == null
//                   ? null
//                   : () {
//                       StripePayment.confirmPaymentIntent(
//                         PaymentIntent(
//                           clientSecret: _currentSecret,
//                           paymentMethodId: _paymentMethod.id,
//                         ),
//                       ).then((paymentIntent) {
//                         _scaffoldKey.currentState?.showSnackBar(SnackBar(
//                             content: Text(
//                                 'Received ${paymentIntent.paymentIntentId}')));
//                         setState(() {
//                           _paymentIntent = paymentIntent;
//                         });
//                       }).catchError(setError);
//                     },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

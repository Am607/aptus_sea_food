import 'package:aptusseafood/Controller/restApi.dart';
import 'package:aptusseafood/view/bulkOrder/conformationPage.dart';
import 'package:aptusseafood/view/bulkOrder/strip.dart';
import 'package:aptusseafood/widgets/CommonWidgets.dart';
import 'package:flutter/material.dart';

class PaymentOptionPage extends StatefulWidget {
  final double totalPrice;
  final String address;
  final String modeoff;
  final String date;
  final String abnNo;
  final String companyNo;
  const PaymentOptionPage(
      {Key? key,
      required this.totalPrice,
      required this.abnNo,
      required this.companyNo,
      required this.date,
      required this.address,
      required this.modeoff})
      : super(key: key);

  @override
  _PaymentOptionPageState createState() => _PaymentOptionPageState();
}

class _PaymentOptionPageState extends State<PaymentOptionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text(
          'Mode of Payment',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: StripPage(
              abnNo: widget.abnNo,
              companyNo: widget.companyNo,
              date: widget.date,
              totalPrice: widget.totalPrice,
              address: widget.address,
              modeoff: widget.modeoff,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: appButtonBlackc(
                function: () {
                  RsetAPi restApi = RsetAPi();
                  restApi
                      .bulkOrder(
                        payLater: '1',
                        abnNo: '${widget.abnNo}',
                        companyName: '${widget.companyNo}',
                        date: '${widget.date}',
                        modeofdelivery: '${widget.modeoff}',
                        address: '${widget.address}',
                        transactionid: '',
                        amount: '${widget.totalPrice}',
                      )
                      .then((value) => {
                            if (value.status == true)
                              {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ConfirmPage()))
                              }
                            else
                              {
                                toast('Order Faild'),
                              }
                          });
                },
                name: "Order Slip",
                context: context),
          ),

          Text('Only For Approved Credit Holders')
        ],
      ),
    );
  }
}





















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

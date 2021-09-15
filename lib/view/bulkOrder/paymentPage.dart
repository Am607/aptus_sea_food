import 'package:aptusseafood/view/bulkOrder/conformationPage.dart';
import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.blue),
        elevation: 0,
        backgroundColor: Colors.white30,
        title: Text(
          'Stripe PaymentPage',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      body: Container(
        child: Center(
          child: TextButton(
            child: Text('Continue'),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => ConfirmPage()),
                (Route<dynamic> route) => false,
              );
            },
          ),
        ),
      ),
    );
  }
}

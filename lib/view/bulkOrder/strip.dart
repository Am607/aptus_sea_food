import 'package:aptusseafood/Controller/restApi.dart';
import 'package:aptusseafood/model/stripModel.dart';
import 'package:aptusseafood/view/bulkOrder/conformationPage.dart';
import 'package:aptusseafood/widgets/CommonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class StripPage extends StatefulWidget {
  final double totalPrice;
  final String address;
  final String modeoff;
  final String date;
  final String abnNo;
  final String companyNo;

  const StripPage(
      {Key? key,
      required this.totalPrice,
      required this.abnNo,
      required this.companyNo,
      required this.date,
      required this.address,
      required this.modeoff})
      : super(key: key);

  @override
  _StripPageState createState() => _StripPageState();
}

class _StripPageState extends State<StripPage> {
  // Map<String, dynamic>? paymentIntentData;
  late Strip? data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    RsetAPi()
        .makeIntent((widget.totalPrice * 100).toInt().toString())
        .then((value) {
      data = value;
      print('called');
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.black,
      ),
      child: Text(
        "Pay",
        style: GoogleFonts.lato(
            textStyle: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        )),
      ),
      onPressed: () {
        makePayemnt();
      },
    );
  }

  Future<void> makePayemnt() async {
    // final url =
    //     Uri.parse('http://aptusseafoods.com/api/payment-intent?amount=100');
    // final response =
    //     await http.post(url, headers: {'Content-Type': 'application/json'});
    // print(response.body);
    // stripFromJson(response.body);
    // paymentIntentData = json.decode(response.body);

    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
      paymentIntentClientSecret: '${data?.data?.clientSecret}',
      applePay: true,
      googlePay: true,
      style: ThemeMode.light,
      merchantCountryCode: 'AU',
      merchantDisplayName: 'Aptus SeaFood',

    ));
    setState(() {});
    displayPaymentSheet();
  }

  Future<void> displayPaymentSheet() async {
    print('called');
    try {
      await Stripe.instance.presentPaymentSheet(
          parameters: PresentPaymentSheetParameters(

        clientSecret: '${data?.data?.clientSecret}',
        confirmPayment: true,
      ));
      setState(() {});
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBar(content: Text('Payment Success')));
      toast('Payment succsess');
      RsetAPi restApi = RsetAPi();
      restApi
          .bulkOrder(
            abnNo: '${widget.abnNo}',
            companyName: '${widget.companyNo}',
            date: '${widget.date}',
            modeofdelivery: '${widget.modeoff}',
            address: '${widget.address}',
            transactionid: '1234',
            amount: '${widget.totalPrice}',
          )
          .then((value) => {
                if (value.status == true)
                  {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => ConfirmPage()))
                  }
                else
                  {
                    toast('Order Faild'),
                  }
              });
    } catch (e) {
      print('erroe is => $e');
      toast('Something went wrong');
    }
  }
}

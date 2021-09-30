// import 'package:flutter/services.dart';
// import 'package:stripe_payment/stripe_payment.dart';

// class PaymentService {
//   static String apiURL = 'https://api.stripe.com/v1';
//   static String paymentApiUrl = '${PaymentService.apiURL}/payment_intents';
//   static String secret =
//       'sk_test_51JfPscSJq6xO3Mt6AED8Ov9sw0w9ptx4i8VFHuKtqkgrhAfF1NVAQ9dkBJcYMYNYhGSgK1jOdtUicWF36awMSXGi00n3CRK2QQ'; //your secret from stripe dashboard
//   static Map<String, String> headers = {
//     'Authorization': 'Bearer ${PaymentService.secret}',
//     'Content-Type': 'application/x-www-form-urlencoded'
//   };
//   static init() {
//     StripePayment.setOptions(StripeOptions(
//         publishableKey:
//             "pk_test_51JfPscSJq6xO3Mt6uViE2n4zhx5ADWcPOtklEsa0NYyHqvG3srn4n8S6OpEAawPguWHamXTZiI6o2bAvsw9Hlrwu00aXjMcxjI", // user your api key
//         merchantId: "Test",
//         androidPayMode: 'test'));
//   }
//   //! exiting cart

//   static Future<PaymentResponse> choseExistingCard(
//       {required String amount, required String currency, required CreditCard card}) async {
//     try {
//       var stripePaymentMethod = await StripePayment.createPaymentMethod(
//           PaymentMethodRequest(card: card));
//       var stripePaymentIntent =
//           await StripeService.createPaymentIntent(amount, currency);
//       var response = await StripePayment.confirmPaymentIntent(PaymentIntent(
//           clientSecret: stripePaymentIntent['client_secret'],
//           paymentMethodId: stripePaymentMethod.id));

//       if (response.status == 'succeeded') {
//         //if the payment process success
//         return  StripeTransactionResponse(
//             message: 'Transaction successful', success: true);
//       } else {
//         //payment process fail
//         return new StripeTransactionResponse(
//             message: 'Transaction failed', success: false);
//       }
//     } on PlatformException catch (error) {
//       return StripeService.getPlatformExceptionErrorResult(err);
//     } catch (error) {
//       return new StripeTransactionResponse(
//           //convert the error to string and assign to message variable for json resposne
//           message: 'Transaction failed: ${error.toString()}',
//           success: false);
//     }
//   }

// //! new card

//   static Future<StripeTransactionResponse> addNewCard(
//       {String amount, String currency}) async {
//     try {
//       var stripePaymentMethod = await StripePayment.paymentRequestWithCardForm(
//           CardFormPaymentRequest());
//       var stripePaymentIntent =
//           await StripeService.createPaymentIntent(amount, currency);
//       var response = await StripePayment.confirmPaymentIntent(PaymentIntent(
//           clientSecret: stripePaymentIntent['client_secret'],
//           paymentMethodId: stripePaymentMethod.id));

//       if (response.status == 'succeeded') {
//         //if the payment process success
//         return new StripeTransactionResponse(
//             message: 'Transaction successful', success: true);
//       } else {
//         //payment process fail
//         return new StripeTransactionResponse(
//             message: 'Transaction failed', success: false);
//       }
//     } on PlatformException catch (error) {
//       return StripeService.getPlatformExceptionErrorResult(error);
//     } catch (error) {
//       return new StripeTransactionResponse(
//           //convert the error to string and assign to message variable
//           message: 'Transaction failed: ${error.toString()}',
//           success: false);
//     }
//   }

//   static Future<Map<String, dynamic>> createPaymentIntent(String amount, String currency) async {
//     try {
//         Map<String, dynamic> body = {
//             'amount': amount, // amount charged will be specified when the method is called
//             'currency': currency, // the currency
//             'payment_method_types[]': 'card' //card
//         };
//         var response =
//             await http.post(
//                 StripeService.paymentApiUrl,  //api url
//                 body: body,  //request body
//                 headers: StripeService.headers //headers of the request specified in the base class
//             );
//         return jsonDecode(response.body); //decode the response to json
//     } catch (error) {
//         print('Error occured : ${error.toString()}');
//     }
//     return null;
// }
// }

// class PaymentResponse {
//   String message; // message from the response
//   bool success; //state of the processs

//   //class constructor
//   PaymentResponse({required this.message, required this.success});
// }

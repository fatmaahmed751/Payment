import 'dart:developer';

import 'package:Payment/Models/amount_model.dart';
import 'package:Payment/Models/payment_intent_input_model.dart';
import 'package:Payment/Modules/Payment/payment_data_handler.dart';
import 'package:Payment/Modules/Payment/widgets/success_payment.dart';
import 'package:Payment/Utilities/router_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';

import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:go_router/go_router.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../Models/ephemral_key_model.dart';
import '../../Models/init_payment_sheet_model.dart';
import '../../Models/items_list_model.dart';
import '../../Models/payment_intent_model.dart';
import '../../Utilities/api_keys.dart';

class PaymentController extends ControllerMVC {
// singleton
  factory PaymentController() {
    _this ??= PaymentController._();
    return _this!;
  }

  static PaymentController? _this;

  PaymentController._();

  bool loading = false, autoValidate = false;
  bool isClick = true;
  PaymentIntentInputModel? paymentIntentInputModel;
  PaymentIntentModel? paymentIntentModel;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Future<PaymentIntentModel?> paymentForProduct(
  //     PaymentIntentInputModel paymentIntentInputModel) async {
  //   setState(() {
  //     loading = true;
  //   });
  //
  //   final result = await PaymentDataHandler.payment(
  //       amount: paymentIntentInputModel.amount,
  //       currency: paymentIntentInputModel.currency,
  //       secretKey: ApiKeys.paymentApiSecretKey,
  //       customerId: paymentIntentInputModel.customerId);
  //
  //   setState(() {
  //     loading = false;
  //   });
  //
  //   return result.fold(
  //     (l) {
  //       print("Payment failed: ${l.errorModel.statusMessage}");
  //       return null;
  //     },
  //     (r) {
  //       return r;
  //     },
  //   );
  // }
  //
  // Future<EphemeralKeyModel?> createEphemeralKeyForCustomer(
  //     {required String customerId}) async {
  //   setState(() {
  //     loading = true;
  //   });
  //
  //   final result =
  //       await PaymentDataHandler.createEphemeralKey(customerId: customerId);
  //
  //   setState(() {
  //     loading = false;
  //   });
  //
  //   return result.fold(
  //     (l) {
  //       print("Payment failed: ${l.errorModel.statusMessage}");
  //       return null;
  //     },
  //     (r) {
  //       return r;
  //     },
  //   );
  // }
  //
  // Future initPaymentSheet(
  //     {required InitPaymentSheetModel initPaymentSheetModel}) async {
  //   await Stripe.instance.initPaymentSheet(
  //       //هذا يستدعي الدالة initPaymentSheet من مكتبة flutter_stripe.
  //       paymentSheetParameters: SetupPaymentSheetParameters(
  //           //نمرر هنا كائن من نوع SetupPaymentSheetParameters يحتوي على الإعدادات المطلوبة لتهيئة شاشة الدفع.
  //           merchantDisplayName: 'Pizza Shop',
  //           paymentIntentClientSecret: initPaymentSheetModel
  //               .clientSecret, //المفتاح السري الخاص بنية الدفع/هذا هو المفتاح السري الخاص بـ PaymentIntent الذي تم إنشاؤه مسبقًا في السيرفر.
  //           customerId: 'cus_ShPPxjuZGB5viQ', //initPaymentSheetModel.customerId
  //           // customerEphemeralKeySecret: initPaymentSheetModel
  //           //     .ephemeralKeySecret //مفتاح مؤقت خاص بالعميل
  //           ));
  // }
  //
  // Future<void> displayPaymentSheet(BuildContext context) async {
  //   try {
  //     await Stripe.instance.presentPaymentSheet();
  //     print("Payment successful");
  //     //Navigator.pop(context);
  //     GoRouter.of(context).pushNamed(SuccessPayment.routeName);
  //   } on Exception catch (e) {
  //     print("Payment cancelled or failed: $e");
  //   }
  // }
  //
  // Future makePayment(
  //     {required PaymentIntentInputModel paymentIntentInputModel}) async {
  //   PaymentIntentModel? paymentIntentModel =
  //       await paymentForProduct(paymentIntentInputModel);
  //   EphemeralKeyModel? ephemeralKeyModel = await createEphemeralKeyForCustomer(
  //       customerId: paymentIntentInputModel.customerId);
  //   if (paymentIntentModel == null || paymentIntentModel.clientSecret == null) {
  //     print("Failed to create payment intent.");
  //     return;
  //   }
  //   var initPaymentSheetModel = InitPaymentSheetModel(
  //       clientSecret: paymentIntentModel.clientSecret!,
  //       customerId: paymentIntentInputModel.customerId,
  //       ephemeralKeySecret: ephemeralKeyModel!.secret!);
  //   await initPaymentSheet(initPaymentSheetModel: initPaymentSheetModel);
  //   await displayPaymentSheet(currentContext_!);
  // }
  Future<PaymentIntentModel?> paymentForProduct(PaymentIntentInputModel paymentIntentInputModel) async {
    setState(() {
      loading = true;
    });

    final result = await PaymentDataHandler.payment(
      amount: paymentIntentInputModel.amount,
      currency: paymentIntentInputModel.currency,
      customerId:paymentIntentInputModel.customerId ,
      secretKey: ApiKeys.paymentApiSecretKey,
    );

    setState(() {
      loading = false;
    });

    return result.fold(
          (l) {
        print("Payment failed: ${l.errorModel.statusMessage}");
        return null;
      },
          (r) {
        return r;
      },
    );
  }

  Future initPaymentSheet({required String paymentIntentClientSecret })async{
    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          merchantDisplayName: 'Flutter Stripe Store Demo',
          paymentIntentClientSecret: paymentIntentClientSecret,
        )
    );
  }
  Future<void> displayPaymentSheet(BuildContext context) async {
    try {
      await Stripe.instance.presentPaymentSheet();
      GoRouter.of(context).pushNamed(SuccessPayment.routeName);
      print("Payment successful");
    } on Exception catch (e) {
      print("Payment cancelled or failed: $e");
    }
  }

  Future makePayment({required PaymentIntentInputModel paymentIntentInputModel,required BuildContext context})async{
    PaymentIntentModel?  paymentIntentModel = await paymentForProduct(paymentIntentInputModel);
    if (paymentIntentModel == null || paymentIntentModel.clientSecret == null) {
      print("Failed to create payment intent.");
      return;
    }
    await initPaymentSheet(paymentIntentClientSecret:paymentIntentModel.clientSecret!);
    await displayPaymentSheet(context);
  }
  void testPayPallPayment(BuildContext context) {
    var amount = AmountModel(
        total: "100",
        currency: "USD",
        details: Details(shipping: "0", shippingDiscount: 0, subtotal: "100"));
    List<OrderOfItem> items =[
      OrderOfItem(
       name :"Apple",
       quantity: 10,
       price: "4",
       currency:"USD",
      ),
      OrderOfItem(
        name :"Apple",
        quantity: 5,
        price: "12",
        currency:"USD",
      ),
    ];
    var ItemOfList =ItemsListModel(items: items );
   showWebViewTransaction(context, amount, ItemOfList);
  }

  void showWebViewTransaction(
      BuildContext context, AmountModel amount, ItemsListModel ItemOfList) {
     Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => PaypalCheckoutView(
        sandboxMode: true,
        clientId:ApiKeys.payPalClientId ,
        secretKey:ApiKeys.payPalSecretKey,
        transactions: [
          {
            "amount": amount.toJson(),
            "description": "The payment transaction description.",
            // "payment_options": {
            //   "allowed_payment_method":
            //       "INSTANT_FUNDING_SOURCE"
            // },
            "item_list":ItemOfList.toJson()
          }
        ],
        note: "Contact us for any questions on your order.",
        onSuccess: (Map params) async {
//           Navigator.pushAndRemoveUntil(context,
//               MaterialPageRoute(builder: (context){
// return const SuccessPayment();
//               }),
//              ModalRoute.withName(SuccessPayment.routeName)
//           );
            //  (predicate);
Navigator.pop(context);
        GoRouter.of(context).pushNamed
          (SuccessPayment.routeName);
        },
        onError: (error) {
          log("onError :$error");
          print("onError: $error");
          Navigator.pop(context);
        },
        onCancel: () {
          print('cancelled:');
          Navigator.pop(context);
        },
      ),
    ));
  }
}
// shipping address is not required though
//   "shipping_address": {
//     "recipient_name": "tharwat",
//     "line1": "Alexandria",
//     "line2": "",
//     "city": "Alexandria",
//     "country_code": "EG",
//     "postal_code": "21505",
//     "phone": "+00000000",
//     "state": "Alexandria"
//  },



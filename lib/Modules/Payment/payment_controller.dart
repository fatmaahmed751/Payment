import 'package:Payment/Models/payment_intent_input_model.dart';
import 'package:Payment/Modules/Payment/payment_data_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../Models/payment_intent_model.dart';
import '../../Utilities/api_keys.dart';
import '../../Utilities/strings.dart';
import '../../generated/assets.dart';
import '../Payment/Widgets/payment_success_methods_widget.dart';

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

  Future<PaymentIntentModel?> paymentForProduct(PaymentIntentInputModel paymentIntentInputModel) async {
    setState(() {
      loading = true;
    });

    final result = await PaymentDataHandler.payment(
      amount: paymentIntentInputModel.amount,
      currency: paymentIntentInputModel.currency,
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
  Future<void> displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      print("Payment successful");
    } on Exception catch (e) {
      print("Payment cancelled or failed: $e");
    }
  }

  Future makePayment({required PaymentIntentInputModel paymentIntentInputModel})async{
    PaymentIntentModel?  paymentIntentModel = await paymentForProduct(paymentIntentInputModel);
    if (paymentIntentModel == null || paymentIntentModel.clientSecret == null) {
      print("Failed to create payment intent.");
      return;
    }
    await initPaymentSheet(paymentIntentClientSecret:paymentIntentModel.clientSecret!);
await displayPaymentSheet();
  }
}

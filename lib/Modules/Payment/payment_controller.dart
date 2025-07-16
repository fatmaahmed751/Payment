import 'package:Payment/Models/payment_intent_input_model.dart';
import 'package:Payment/Modules/Payment/payment_data_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
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
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

paymentForProduct(PaymentIntentInputModel paymentIntentInputModel) async {
    setState(() {
      loading = true;
    });
    final result = await PaymentDataHandler.payment(
        amount: paymentIntentInputModel.amount,
        currency: paymentIntentInputModel.currency,
        stripeSecretKey: "sk_test_51RlIE8GaB6re3GlpFytquseARIby7iSRadWluakO7V0DQyfAsOh1vvX30td8hjie71UL9lxrpepdB3pKr470dYPp00mqdAMFDG");
    result.fold((l) {
      print("Payment failed: ${l.errorModel.statusMessage}");
      setState(() {
        loading = false;
      });

    }, (r) async {
      setState(() {
        loading = false;
      });
    });
}

  // Future visaPaymentSuccess(BuildContext context) {
  //   return showModalBottomSheet(
  //     context: context,
  //     // isScrollControlled: true,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
  //     ),
  //     builder: (context) => PaymentSuccessBottomSheetWidget(
  //       image: Assets.imagesVisaImage,
  //       text: Strings.successVisa.tr,
  //     ),
  //   );
  // }

  // Future cashPaymentSuccess(BuildContext context) {
  //   return showModalBottomSheet(
  //     context: context,
  //     // isScrollControlled: true,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
  //     ),
  //     builder: (context) => PaymentSuccessBottomSheetWidget(
  //       image: Assets.imagesCashImage,
  //       text: Strings.successCash.tr,
  //     ),
  //   );
  // }
}

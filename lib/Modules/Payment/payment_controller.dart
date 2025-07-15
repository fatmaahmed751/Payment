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
  int selectedMethod = 0;
  late TextEditingController cardNumberController,
      cardNameController,
      expirationDateController,
      cvvController;
  @override
  void initState() {
    cardNumberController = TextEditingController();
    cardNameController = TextEditingController();
    expirationDateController = TextEditingController();
    cvvController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    cardNumberController.dispose();
    cardNameController.dispose();
    expirationDateController.dispose();
    cvvController.dispose();
    super.dispose();
  }

  void selectPaymentMethod(int method) {
    if (selectedMethod == method) {
      selectedMethod = 0;
    } else {
      selectedMethod = method;
    }
    setState(() {});
  }

  init() {}

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

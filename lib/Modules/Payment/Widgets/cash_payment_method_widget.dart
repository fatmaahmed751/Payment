import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../Utilities/strings.dart';
import '../../../Utilities/text_style_helper.dart';
import '../../../Utilities/theme_helper.dart';
import '../../../Widgets/custom_button_widget.dart';
import '../../../Widgets/custom_text.dart';
import '../payment_controller.dart';

class CashPaymentMethodWidget extends StatefulWidget {
  const CashPaymentMethodWidget({super.key});

  @override
  createState() => CashPaymentMethodWidgetState();
}

class CashPaymentMethodWidgetState extends StateMVC<CashPaymentMethodWidget> {
  CashPaymentMethodWidgetState() : super(PaymentController()) {
    con = PaymentController();
  }

  late PaymentController con;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsetsDirectional.symmetric(horizontal: 24.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(10.h),
          CustomText(
            text: "cashText",
            textStyle: TextStyleHelper.of(context)
                .h_18
                .copyWith(color: ThemeClass.of(context).mainBlack),
          ),
          Gap(500.h),
          CustomButtonWidget.primary(
              title:"payNow",
              onTap: () {
               // con.cashPaymentSuccess(context);
              }),
          Gap(20.h)
        ],
      ),
    );
  }
}

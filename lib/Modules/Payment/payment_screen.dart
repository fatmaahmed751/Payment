import "package:Payment/Modules/Payment/payment_controller.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/svg.dart";
import "package:gap/gap.dart";
import "package:mvc_pattern/mvc_pattern.dart";
import "../../Utilities/strings.dart";
import "../../Widgets/custom_app_bar_widget.dart";
import "../../Widgets/custom_button_widget.dart";
import "../../generated/assets.dart";
import "Widgets/cash_payment_method_widget.dart";
import "Widgets/visa_payment_method_widget.dart";
import "package:flutter_svg/flutter_svg.dart";
import "../../../Utilities/text_style_helper.dart";
import "../../../Utilities/theme_helper.dart";

class PaymentScreen extends StatefulWidget {
  static const routeName = "PaymentScreen";
 // final ShippingProductModel shippingProductModel;
  const PaymentScreen({super.key,
   // required this.shippingProductModel
  });

  @override
  createState() => PaymentScreenState();
}

class PaymentScreenState extends StateMVC<PaymentScreen> {
  PaymentScreenState() : super(PaymentController()) {
    con = PaymentController();
  }

  late PaymentController con;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(0, 80.h),
        child: CustomAppBarWidget.detailsScreen(
          title: "paymentMethod",
          icon: "",
        ),
      ),
      body:
      SafeArea(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Padding(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w),
                child: togglePaymentsMethodsWidget(),
              ),
              con.isClick
                  ? VisaPaymentMethodWidget()
                  : CashPaymentMethodWidget(),
              CustomButtonWidget.primary(

              )
            ],
          ),
        ),

    );
  }
  // Widget togglePaymentsMethodsWidget() {
  //   final paymentMethods = [
  //     {
  //       'isSelected': con.isClick,
  //       'onTap': () => setState(() => con.isClick = true),
  //       'widget': SvgPicture.asset(
  //         Assets.imagesVisalogo,
  //         color: con.isClick
  //             ? ThemeClass.of(context).background
  //             : ThemeClass.of(context)
  //             .secondaryBlackColor
  //             .withAlpha((0.6 * 255).toInt()),
  //       ),
  //     },
  //     {
  //       'isSelected': !con.isClick,
  //       'onTap': () => setState(() => con.isClick = false),
  //       'widget': Text(
  //         Strings.cash.tr,
  //         textAlign: TextAlign.center,
  //         style: TextStyleHelper.of(context).h_16.copyWith(
  //           fontWeight: FontWeight.w600,
  //           color: !con.isClick
  //               ? ThemeClass.of(context).background
  //               : ThemeClass.of(context)
  //               .secondaryBlackColor
  //               .withAlpha((0.6 * 255).toInt()),
  //           decoration: TextDecoration.none,
  //         ),
  //       ),
  //     }
  //   ];
  //
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: List.generate(paymentMethods.length, (index) {
  //       final method = paymentMethods[index];
  //       return Padding(
  //         padding: EdgeInsetsDirectional.only(end: index == 0 ? 10.w : 0),
  //         child: GestureDetector(
  //           onTap: method['onTap'] as VoidCallback,
  //           child: Container(
  //             width: 170.w,
  //             height: 56.h,
  //             padding: EdgeInsetsDirectional.symmetric(
  //               vertical: 16.h,
  //               horizontal: 16.w,
  //             ),
  //             decoration: BoxDecoration(
  //               color: method['isSelected'] as bool
  //                   ? ThemeClass.of(context).primaryColor
  //                   : Colors.transparent,
  //               borderRadius: BorderRadius.circular(30.r),
  //               border: Border.all(
  //                 color: (method['isSelected'] as bool)
  //                     ? Colors.transparent
  //                     : ThemeClass.of(context)
  //                     .secondaryBlackColor
  //                     .withAlpha((0.6 * 255).toInt()),
  //               ),
  //             ),
  //             clipBehavior: Clip.hardEdge,
  //             child: Center(child: method['widget'] as Widget),
  //           ),
  //         ),
  //       );
  //     }),
  //   );
  // }

  //
  Widget togglePaymentsMethodsWidget() {
    final theme = ThemeClass.of(context);
    final secondaryBlackWithOpacity = theme.secondaryBlackColor.withOpacity(0.6);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildPaymentMethodButton(
          isActive: con.isClick,
          child: SvgPicture.asset(
            Assets.imagesVisaLogo,
            color: con.isClick ? theme.background : secondaryBlackWithOpacity,
          ),
          onTap: () => _togglePaymentMethod(true),
        ),
        Gap(10.w),
        _buildPaymentMethodButton(
          isActive: !con.isClick,
          child: Text(
           " Strings.cash.tr",
            textAlign: TextAlign.center,
            style: TextStyleHelper.of(context).h_16.copyWith(
              fontWeight: FontWeight.w600,
              color: !con.isClick ? theme.background : secondaryBlackWithOpacity,
              decoration: TextDecoration.none,
            ),
          ),
          onTap: () => _togglePaymentMethod(false),
        ),
      ],
    );
  }

  void _togglePaymentMethod(bool isCard) {
    setState(() {
      con.isClick = isCard;
    });
  }

  Widget _buildPaymentMethodButton({
    required bool isActive,
    required Widget child,
    required VoidCallback onTap,
  }) {
    final theme = ThemeClass.of(context);
    final secondaryBlackWithOpacity = theme.secondaryBlackColor.withOpacity(0.6);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
        width: 170.w,
        height: 56.h,
        decoration: BoxDecoration(
          color: isActive ? theme.primaryColor : Colors.transparent,
          border: Border.all(
            color: isActive ? Colors.transparent : secondaryBlackWithOpacity,
          ),
          borderRadius: BorderRadius.circular(30.r),
        ),
        clipBehavior: Clip.hardEdge,
        child: Center(child: child),
      ),
    );
  }
//   Widget togglePaymentsMethodsWidget() => Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           GestureDetector(
//             onTap: () {
//               setState(() {
//                 con.isClick = !con.isClick;
//               });
//             },
//             child: Container(
//               padding: EdgeInsetsDirectional.symmetric(
//                   vertical: 20.h, horizontal: 16.w),
//               width: 170.w,
//               height: 56.h,
//               decoration: BoxDecoration(
//                   color: con.isClick
//                       ? ThemeClass.of(context).primaryColor
//                       : Colors.transparent,
//                   border: Border.all(
//                     color: con.isClick
//                         ? Colors.transparent
//                         : ThemeClass.of(context)
//                             .secondaryBlackColor
//                             .withAlpha((0.6* 255).toInt()),
//                   ),
//                   borderRadius: BorderRadius.circular(30.r)),
//               clipBehavior: Clip.hardEdge,
//               child: SvgPicture.asset(
//                 Assets.imagesVisalogo,
//                 color: con.isClick
//                     ? ThemeClass.of(context).background
//                     : ThemeClass.of(context)
//                         .secondaryBlackColor
//                         .withAlpha((0.6* 255).toInt()),
//               ),
//             ),
//           ),
//           Gap(10.w),
//           GestureDetector(
//             onTap: () {
//               setState(() {
//                 con.isClick = !con.isClick;
//               });
//             },
//             child: Container(
//               padding: EdgeInsetsDirectional.symmetric(
//                   horizontal: 16.w, vertical: 16.h),
//               width: 170.w,
//               height: 56.h,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(30.r),
//                 color: !con.isClick
//                     ? ThemeClass.of(context).primaryColor
//                     : ThemeClass.of(context).background,
//                 border: Border.all(
//                   color: !con.isClick
//                       ? Colors.transparent
//                       : ThemeClass.of(context)
//                           .secondaryBlackColor
//                           .withAlpha((0.6* 255).toInt()),
//                 ),
//               ),
//               clipBehavior: Clip.hardEdge,
//               child: Text(
//                 Strings.cash.tr,
//                 textAlign: TextAlign.center,
//                 style: TextStyleHelper.of(context).h_16.copyWith(
//                     fontWeight: FontWeight.w600,
//                     color: !con.isClick
//                         ? ThemeClass.of(context).background
//                         : ThemeClass.of(context)
//                             .secondaryBlackColor
//                             .withAlpha((0.6* 255).toInt()),
//                     decoration: TextDecoration.none),
//               ),
//             ),
//           ),
//         ],
//       );
 }

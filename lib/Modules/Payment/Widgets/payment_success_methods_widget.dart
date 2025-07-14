import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';


import '../../../Utilities/strings.dart';
import '../../../Utilities/text_style_helper.dart';
import '../../../Utilities/theme_helper.dart';
import '../../../Widgets/custom_button_widget.dart';

class PaymentSuccessBottomSheetWidget extends StatelessWidget {
  final String text;
  final String image;
  const PaymentSuccessBottomSheetWidget(
      {super.key, required this.text, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
      ),
      child: Padding(
        padding:
            EdgeInsetsDirectional.symmetric(horizontal: 24.w, vertical: 16.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 240.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.r),
              ),
              child: SvgPicture.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
            Gap(16.h),
            Text(
                textAlign: TextAlign.center,
                text,
                style: TextStyleHelper.of(context).b_16.copyWith(
                    color: ThemeClass.of(context).secondaryBlackColor)),
            Gap(20.h),
            CustomButtonWidget.primary(
                title:" Strings.backHome.tr",
                onTap: () {

                }),
          ],
        ),
      ),
    );
  }
}

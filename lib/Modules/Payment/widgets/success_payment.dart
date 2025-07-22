import 'package:Payment/Modules/Payment/payment_screen.dart';
import 'package:Payment/Widgets/custom_button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../generated/assets.dart';

class SuccessPayment extends StatelessWidget{
  static const routeName = "success";

  const SuccessPayment({super.key});
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: Colors.white,
     body: Column(
       children: [
         SizedBox(
           height: 170.h),

         Container(
           color: Colors.transparent,
          child: Image.asset(Assets.imagesCheck,

          )),
         SizedBox(
             height: 220.h),
         Padding(
           padding:  EdgeInsets.symmetric(horizontal: 16.0),
           child: CustomButtonWidget.primary(
             radius: 20,

             title: "Back To Cart",
             onTap: (){
               GoRouter.of(context).pushNamed(PaymentScreen.routeName);
             },
           ),
         )

       ],
     ),
   );
  }

}
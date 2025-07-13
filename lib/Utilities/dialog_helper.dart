import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DialogHelper{
  final BuildContext context;
  final String? message;
  final String? title;

  DialogHelper({required this.context, this.message, this.title});

  factory DialogHelper.custom({required BuildContext context}){
    return DialogHelper(context: context);
  }

  Future successDialog() async {}
  Future deleteDialog({required warningMessage,required Function() confirmDelete,Function()? cancel}) async{}
  Future editDialog() async{}
  Future errorDialog({Function()? onTapOk,}) async{}


  void customDialog({required Widget dialogWidget,bool dismiss = true,Function()? onDismiss}){
    showGeneralDialog(
      useRootNavigator: true,
      barrierLabel: "",
      context: context,
      barrierDismissible: dismiss,

      transitionDuration: const Duration(milliseconds: 300),
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0)).animate(anim1),
          child: child,
        );
      },
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.symmetric(horizontal: 24.w,vertical: 24.h),
          child: dialogWidget,
        );
      },
    ).then((_)=> onDismiss?.call());
  }
  void customDialogPosition({required Widget dialogWidget,double? left,double? top,double? right,double? bottom,
    bool dismiss = true,Function()? onDismiss})async{
    await showDialog(
      context: context,
      useRootNavigator: true,
      barrierLabel: "",
      barrierDismissible: dismiss,
      builder: (BuildContext context) {
        return Stack(
          children: [
            const SizedBox(width: double.infinity,height: double.infinity,),
            Positioned(
              left: left,
              top: top,
              right: right,
              bottom: bottom,
              child: dialogWidget,
            ),
          ],
        );
      },
    ).then((_) {
      return onDismiss?.call();
    });
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:templete/Utilities/theme_helper.dart';

class BottomSheetHelper{

  static Future bottomSheet({
    required BuildContext context,
    required Widget widget,
    Function? onDismiss,
  }) async {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16.r))),
      backgroundColor: ThemeClass.of(context).mainBlack,
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      useSafeArea: true,
      builder: (BuildContext context)=> widget,).then((_) {
      if (onDismiss != null) onDismiss();
    });
  }

}

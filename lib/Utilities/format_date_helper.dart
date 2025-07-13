
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:Payment/Utilities/shared_preferences.dart';
import 'package:Payment/Utilities/strings.dart';
import 'package:Payment/Utilities/theme_helper.dart';
import 'package:Payment/core/Language/locales.dart';
import 'package:timeago/timeago.dart' as timeago;
class FormatDateHelper {
  static final formatter = DateFormat('EEEE d MMM yyyy',SharedPref.getCurrentLanguage());
  static final birthDateFormat = DateFormat('d - M - y',SharedPref.getCurrentLanguage());
  static final NumberFormat formatterBy2 = NumberFormat("#,##0.00", "en_US");
  static formattedValue(String originalValue) => double.parse(formatterBy2.format(originalValue));
  static  reverseBirthDateFormat(String date) =>  birthDateFormat.parse(date);
  static final formatterCustomTime = DateFormat('hh : mm a',SharedPref.getCurrentLanguage());
  static final formatterCustomChatTime = DateFormat('hh:mm a',);
  static String getTimeAgo(DateTime? time, {bool short = false}) {
    if (time == null) return "";
    String currentLng = SharedPref.getCurrentLanguage();
    bool isAr = currentLng == "ar";
    timeago.setLocaleMessages(
      "$currentLng${short ? "_short" : ""}",
      (short && isAr)
          ? timeago.ArShortMessages()
          : (short && !isAr)
          ? timeago.EnShortMessages()
          : (isAr)
          ? timeago.ArMessages()
          : timeago.EnMessages(),
    );
    return timeago.format(time, locale: "$currentLng${short ? "_short" : ""}");
  }
  static Future <DateTime?> onPickDate({required BuildContext ctx,DateTime? firstDate,DateTime? lastDate}) async {
    DateTime? pickedDate = await showDatePicker(
      context: ctx,
      firstDate: firstDate ?? DateTime(1950),
      initialDate: lastDate ?? DateTime.now(),
      lastDate: lastDate ?? DateTime.now(),
      cancelText: Strings.cancel.tr,
      confirmText: Strings.ok.tr,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(

              primary: ThemeClass.of(context).primaryColor,
              onPrimary: ThemeClass.of(context).secondary,
              onSurface: ThemeClass.of(context).secondary,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                iconColor: ThemeClass.of(context).secondary,
                overlayColor: ThemeClass.of(context).secondary,   // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      return pickedDate;
    }
    return null;
  }
}
import 'package:flutter/material.dart';

import '../../Utilities/shared_preferences.dart';
import '../../Utilities/theme_helper.dart';


class ThemeModel extends ThemeExtension<ThemeModel>{

  static ThemeModel get defaultTheme{
    return ThemeClass.lightTheme();
    // Brightness brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
    // return brightness == Brightness.dark? ThemeClass.darkTheme():ThemeClass.lightTheme();
  }

  final bool isDark;
  final Color background;
  final Color primaryColor;
  final Color mainSecondary;
  final Color mainBlack;
  final Color secondaryBlackColor;
  final Color labelColor;

  final Color success;
  final Color waiting;
  final Color cancel;
  final Color secondary;


  ThemeModel({
    this.isDark = false,
    required this.background,
    required this.primaryColor,
    required this.mainSecondary,
    required this.labelColor,
    required this.success,
    required this.waiting,
    required this.cancel,
    required this.secondary,
    required this.mainBlack,
    required this.secondaryBlackColor,
});

  @override
  ThemeModel copyWith({
    bool? isDark,
    Color? reversedBlackWhite,
    Color? background,
    Color? primaryColor,
    Color? pTint1,
    Color? pTint2,
    Color? pShade1,
    Color? secondary,
    Color? regPrimary,
    Color? regSecondary,
    Color? regFieldBorder,
    Color? sTint1,
    Color? sTint2,
    Color? shade1,
    Color? cardLight,
    Color? labelColor,
    Color? success,
    Color? waiting,
    Color? cancel,
    Color? informative,
    Color? mainBlack,
    Color? bodyColor,
    Color? tabBarColor,
}) {
    return ThemeModel(
      isDark: isDark??this.isDark,
      background: background??this.background,
      primaryColor: primaryColor??this.primaryColor,
      mainSecondary: secondary??this.mainSecondary,
      labelColor: labelColor??this.labelColor,
      success: success??this.success,
      waiting: waiting??this.waiting,
      cancel: cancel??this.cancel,
      secondary: informative??this.secondary,
      mainBlack: mainBlack??this.mainBlack,
      secondaryBlackColor: bodyColor??this.secondaryBlackColor,
    );
  }

  factory ThemeModel.fromJson(Map<String, dynamic> json) => ThemeModel(
    isDark: json["isDark"],
    background: Color(json["background"]),
    primaryColor: Color(json["primaryColor"]),
    mainSecondary: Color(json["secondary"]),
    labelColor: Color(json["labelColor"]),
    success: Color(json["success"]),
    waiting: Color(json["waiting"]),
    cancel: Color(json["cancel"]),
    secondary: Color(json["informative"]),
    mainBlack: Color(json["mainBlack"]),
    secondaryBlackColor: Color(json["bodyColor"]),
  );

  Map<String, dynamic> toJson() => {
    "isDark": isDark,
    "background": background.value,
    "primaryColor": primaryColor.value,
    "secondary": mainSecondary.value,
    "labelColor": labelColor.value,
    "success": success.value,
    "waiting": waiting.value,
    "cancel": cancel.value,
    "informative": secondary.value,
    "mainBlack": mainBlack.value,
    "bodyColor": secondaryBlackColor.value,
  };


  @override
  ThemeModel lerp(ThemeExtension<ThemeModel>? other, double t) {
    if (other is! ThemeModel) {
      return this;
    }
    return SharedPref.getTheme()??defaultTheme;
  }
}
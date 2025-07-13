import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:templete/Utilities/theme_helper.dart';

import '../core/Font/font_provider.dart';

class TextStyleHelper{
  final BuildContext context;
  TextStyleHelper._(this.context);

  static TextStyleHelper of(BuildContext context) => TextStyleHelper._(context);

  double get _fSS => Provider.of<FontProvider>(context,listen: false).fontSizeScale;
  FontFamilyTypes get _fF => Provider.of<FontProvider>(context,listen: false).fontFamily;

  _fontFamily(){
    switch(_fF){
      case FontFamilyTypes.tajawal: return GoogleFonts.tajawal;
      case FontFamilyTypes.cairo: return GoogleFonts.cairo;
      case FontFamilyTypes.poppins: return GoogleFonts.poppins;
    }
  }

  TextStyle  getTextStyle({required double fontSize,FontWeight? fontWeight}) =>
      _fontFamily()(fontSize: (fontSize*_fSS).sp,fontWeight: fontWeight,color: ThemeClass.of(context).mainBlack);


  TextStyle get h1_20 => getTextStyle(fontSize: 20,fontWeight: FontWeight.w700);




  TextStyle get h_24 => getTextStyle(fontSize: 24,fontWeight: FontWeight.w700);
  TextStyle get h_20 => getTextStyle(fontSize: 20,fontWeight: FontWeight.w700);
  TextStyle get h_18 => getTextStyle(fontSize: 18,fontWeight: FontWeight.w700);
  TextStyle get h_16 => getTextStyle(fontSize: 16,fontWeight: FontWeight.w700);
  TextStyle get h_14 => getTextStyle(fontSize: 14,fontWeight: FontWeight.w700);
  TextStyle get h_12 => getTextStyle(fontSize: 12,fontWeight: FontWeight.w700);
  TextStyle get h_10 => getTextStyle(fontSize: 10,fontWeight: FontWeight.w700);
  TextStyle get h_11 => getTextStyle(fontSize: 11,fontWeight: FontWeight.w700);


  TextStyle get b_20 => getTextStyle(fontSize: 20,fontWeight: FontWeight.w400);
  TextStyle get b_16 => getTextStyle(fontSize: 16,fontWeight: FontWeight.w400);
  TextStyle get b_14 => getTextStyle(fontSize: 14,fontWeight: FontWeight.w400);
  TextStyle get b_12 => getTextStyle(fontSize: 12,fontWeight: FontWeight.w400);
  TextStyle get b_10 => getTextStyle(fontSize: 10,fontWeight: FontWeight.w400);
  TextStyle get b_9 => getTextStyle(fontSize: 9,fontWeight: FontWeight.w400);
  TextStyle get b_8 => getTextStyle(fontSize: 8,fontWeight: FontWeight.w400);
  TextStyle get b_6 => getTextStyle(fontSize: 6,fontWeight: FontWeight.w400);

}
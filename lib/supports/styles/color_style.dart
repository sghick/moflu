import 'package:flutter/material.dart';
import 'package:rego/base_core/utils/color_ext.dart';

// https://www.sioe.cn/yingyong/yanse-rgb-16/
class CBColors {
  static const Color clear = Color(0x00000000);
  static const Color white = Color(0xffFFFFFF);
  static const Color litterGrayWhite = Color(0xffFFFBEF);
  static const Color black = Color(0xff333333);
  static const Color darkGray = Color(0xff666666);
  static const Color gray = Color(0xff999999);
  static const Color lightGray = Color(0xffCECECE);

  static const Color orange = Color(0xffCE985B);
  static const Color bloody = Color(0xffFB940F);
  static const Color yellow = Color(0xffFFEB3B);

  static const Color secondary = Color(0xffCE985B); //
  static const Color borderColor = Color(0xFFC3C3C3);

  static const Color red = Color(0xffFF5F5F);
  static const Color reminderRed = Color(0xFFEB3500);
  static const Color pink = Color(0xffE91E63);

  static const Color blue = Color(0xff00BFFF);

  static const Color purple = Color(0xff9C27B0);

  static const Color green = Color(0xff00CB7C);

  static const Color line = Color(0xffEBEBEB);
  static const Color line2 = Color(0xffdBdBdB);
  static const Color mainLine = Color(0xffF5F5F5);
  static const Color shadowBg = Color(0xEEFBFBFB);
  static const Color backgroundColor = Color(0xffF7F7F7);
  static const Color loginBgColor = Color(0xffFAFAFA);

  static const Color CZero = Color(0xffC0C0C0);

  static const Color borderButtonColor = Color(0xff979797);
  static const Color homePageBgColor = Color(0xfff2f2f2);

  /// eg:CBColors.fromRGBStringO('#00CB7C', 0.5)
  static Color fromRGBStringO(String rgbString, double opacity) =>
      ColorExt.fromRGBStringO(rgbString, opacity);

  /// eg:CBColors.fromRGBString('#00CB7C')
  static Color fromRGBString(String rgbString) =>
      ColorExt.fromRGBString(rgbString);
}

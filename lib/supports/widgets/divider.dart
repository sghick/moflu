import 'package:moflu/supports/styles/common_styles.dart';
import 'package:flutter/material.dart';

class CBDivider {
  static Widget v(
      {Color color = CBColors.line,
      double width = ViewStyle.lineWidth,
      double indent = 0,
      double endIndent = 0,
      double margin = 0}) {
    return Container(
      color: color,
      width: width,
      margin: EdgeInsets.only(top: margin, bottom: margin),
      padding: EdgeInsets.only(left: indent, right: endIndent),
    );
  }

  static Widget h({
    Color color = CBColors.line,
    double height = ViewStyle.lineWidth,
    double indent = 0,
    double endIndent = 0,
    double margin = 0,
  }) {
    return Container(
      color: color,
      height: height,
      margin: EdgeInsets.only(left: margin, right: margin),
      padding: EdgeInsets.only(top: indent, bottom: endIndent),
    );
  }
}

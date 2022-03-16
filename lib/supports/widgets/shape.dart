import 'package:moflu/supports/styles/common_styles.dart';
import 'package:flutter/material.dart';

class CBShape {
  /// 边框线:用于Contanier的decoration属性
  static BoxDecoration boxDecoration(
      {Color color = Colors.white,
      double radius = ViewStyle.radius,
      double bolderWidth = ViewStyle.borderWidth,
      Color bolderColor = CBColors.black}) {
    return BoxDecoration(
      //背景
      color: color,
      //设置四周圆角 角度
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      //设置四周边框
      border: new Border.all(width: bolderWidth, color: bolderColor),
    );
  }

  /// 边框线:用于FlatButton的shape属性
  static RoundedRectangleBorder roundBorder(
      {double radius = ViewStyle.radius,
      double bolderWidth = ViewStyle.borderWidth,
      Color bolderColor = CBColors.black}) {
    return RoundedRectangleBorder(
      side: BorderSide(
        color: bolderColor,
        width: bolderWidth,
      ),
      borderRadius: BorderRadius.circular(radius),
    );
  }
}

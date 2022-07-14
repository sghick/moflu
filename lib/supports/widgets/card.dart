import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CBCard extends Container {
  CBCard({
    Key? key,
    EdgeInsets? margin,
    Color color = Colors.white,
    Color shadowColor = const Color(0xFFEAEAEA),
    double shadowRadius = 5.0,
    Offset shadowOffset = const Offset(0, 1),
    EdgeInsets? padding,
    DecorationImage? bgkImg,
    Widget? child,
    GestureTapCallback? onTap,
    GestureLongPressCallback? onLongPress,
  }) : super(
    margin: margin,
    padding: padding,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.all(
        Radius.circular(shadowRadius),
      ),
      image: bgkImg,
      boxShadow: [
        BoxShadow(
          offset: shadowOffset,
          blurRadius: shadowRadius,
          spreadRadius: 0,
          color: shadowColor,
        ),
      ],
    ),
    child: GestureDetector(
      child: Container(
        color: Colors.transparent,
        child: child,
      ),
      onTap: onTap,
      onLongPress: onLongPress,
    ),
  );
}

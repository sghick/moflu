import 'dart:math';

import 'package:flutter/material.dart';

class ColorUtil {
  static Color get randomColor {
    return Color.fromARGB(
      randomColorValue,
      randomColorValue,
      randomColorValue,
      randomColorValue,
    );
  }

  static int get randomColorValue {
    return Random().nextInt(155);
  }
}

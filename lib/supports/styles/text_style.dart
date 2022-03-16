import 'package:flutter/material.dart';
import 'package:rego/base_core/utils/screen_utils.dart';
import 'package:rego/base_core/widgets/text_widgets.dart';

import 'color_style.dart';

class TextSize {
  static final double headline = 18.dp;
  static final double head = 17.dp;
  static final double large = 16.dp;
  static final double normal = 15.dp;
  static final double standard = 14.dp;
  static final double middle = 13.dp;
  static final double small = 12.dp;
  static final double less = 11.dp;
  static final double tiny = 10.dp;
}

extension TextStyleBuilderExtension on TextStyleBuilder {
  // Standard Text Decoration Features
  TextStyleBuilder get bold {
    return weight(FontWeight.bold);
  }

  // Standard Text Size
  TextStyleBuilder get headLine {
    return size(TextSize.headline);
  }

  TextStyleBuilder get headSize {
    return size(TextSize.head);
  }

  TextStyleBuilder get largeSize {
    return size(TextSize.large);
  }

  TextStyleBuilder get middleSize {
    return size(TextSize.middle);
  }

  TextStyleBuilder get standardSize {
    return size(TextSize.standard);
  }

  TextStyleBuilder get normanSize {
    return size(TextSize.normal);
  }

  TextStyleBuilder get smallSize {
    return size(TextSize.small);
  }

  TextStyleBuilder get lessSize {
    return size(TextSize.less);
  }

  TextStyleBuilder get tinySize {
    return size(TextSize.tiny);
  }

  // Standard Text Color
  TextStyleBuilder get white {
    return color(Colors.white);
  }

  TextStyleBuilder get black {
    return color(CBColors.black);
  }

  TextStyleBuilder get darkGray {
    return color(CBColors.darkGray);
  }

  TextStyleBuilder get gray {
    return color(CBColors.gray);
  }

  TextStyleBuilder get lightGray {
    return color(CBColors.lightGray);
  }

  TextStyleBuilder get orange {
    return color(CBColors.orange);
  }

  TextStyleBuilder get bloody {
    return color(CBColors.bloody);
  }
}

TextStyleBuilder get newStyle {
  return TextStyleBuilder();
}

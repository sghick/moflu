import 'package:badges/badges.dart';
import 'package:rego/base_core/widgets/text_widgets.dart';
import 'package:moflu/supports/styles/common_styles.dart';
import 'package:flutter/material.dart';

class CBPointBadge extends Badge {
  CBPointBadge({
    Key? key,
    Color badgeColor = CBColors.red,
    BadgePosition? position,
    bool showBadge = true,
    Widget? badgeContent,
    Widget? child,
  }) : super(
          key: key,
          badgeColor: badgeColor,
          position: position,
          showBadge: showBadge,
          padding: EdgeInsets.all(3.dp),
          badgeContent: badgeContent,
          child: child,
        );
}

class CBTextBadge extends Badge {
  CBTextBadge({
    Key? key,
    String? text,
    Color badgeColor = CBColors.red,
    BadgePosition? position,
    bool? showBadge,
    Widget? child,
  }) : super(
          key: key,
          badgeColor: badgeColor,
          position: position,
          showBadge: showBadge ?? text?.isEmpty ?? false,
          shape:
              (text?.length ?? 0) > 1 ? BadgeShape.square : BadgeShape.circle,
          borderRadius: BorderRadius.circular(9.dp),
          padding: EdgeInsets.all(3.dp),
          badgeContent: (text != null)
              ? Container(
                  constraints: BoxConstraints(minHeight: 9.dp, minWidth: 9.dp),
                  child: SimpleText(text, style: newStyle.white.size(9.dp)),
                )
              : null,
          child: child,
        );
}

class CBNumberBadge extends CBTextBadge {
  CBNumberBadge({
    Key? key,
    int count = 0,
    int maxCount = 99,
    BadgePosition? position,
    Widget? child,
  }) : super(
          key: key,
          text: count > 99 ? '$maxCount+' : '$count',
          showBadge: count > 0,
          position: position,
          child: child,
        );
}

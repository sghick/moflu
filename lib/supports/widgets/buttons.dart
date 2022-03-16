import 'package:rego/base_core/routes/navigators.dart';
import 'package:moflu/supports/styles/common_styles.dart';
import 'package:flutter/material.dart';

BottomNavigationBarItem bottomBarItem(
    {required String icon, required String selIcon, required String title}) {
  return BottomNavigationBarItem(
    icon: Image.asset(icon, fit: BoxFit.cover, width: 22, height: 22),
    activeIcon: Image.asset(selIcon, fit: BoxFit.cover, width: 22, height: 22),
    label: title,
  );
}

Widget titleBarBackButton(BuildContext context, {GestureTapCallback? onBack}) {
  return GestureDetector(
    child: Container(
      padding: EdgeInsets.fromLTRB(5.dp, 0.dp, 0.dp, 0.dp),
      child: Image.asset(
        'icon_black_back'.webP,
        width: 24.dp,
        height: 24.dp,
      ),
    ),
    onTap: onBack != null
        ? onBack
        : () {
            goBack(context: context);
          },
  );
}

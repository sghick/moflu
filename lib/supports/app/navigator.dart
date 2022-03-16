import 'package:rego/base_core/routes/navigator_observer.dart';
import 'package:rego/base_core/routes/navigators.dart';
import 'package:flutter/material.dart';

abstract class AppNavigatorMixin implements AppNavigator {
  @override
  NavigationHistoryObserver get navigationHistoryObserver => navigatorObserver;

  @override
  GlobalKey<NavigatorState> get navigatorKey => globalNavigatorKey;
}

Future<T?> pushPage<T>(Widget page, {BuildContext? context}) {
  context ??= navigatorContext;
  return Navigator.of(context!).push(MaterialPageRoute(builder: (context) {
    return page;
  }));
}

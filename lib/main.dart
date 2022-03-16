import 'package:flutter/services.dart';
import 'package:rego/base_core/routes/page_jump.dart';
import 'package:moflu/configs/page_jump.dart';
import 'package:moflu/configs/routes.dart';
import 'package:moflu/supports/app/application.dart';
import 'package:flutter/material.dart';

void main() {
  MyApp().start();
}

class MyApp extends ApplicationMixin {
  @override
  String get appScheme => 'wellcomeback';

  @override
  Checking get checkingHandler => (
      {CheckingCallback? onPassed,
      CheckingCallback? onCanceled,
      dynamic checkingType}) {};

  @override
  String get initialRoute => '/root';

  @override
  Map<String, PageJumpHandler> get jumpHandlers => globalJumpHandlers;

  @override
  Map<String, WidgetBuilder> get routes => globalRouters;

  @override
  String get title => '';

  @override
  PageJumpHandler get webJumpHandler => globalWebJumpHandler;
}

import 'package:rego/base_core/routes/navigators.dart';
import 'package:rego/base_core/routes/page_jump.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:moflu/pages/advert/advert_page.dart';
import 'package:moflu/pages/debug/debug_page.dart';
import 'package:moflu/pages/home/home_page.dart';
import 'package:moflu/pages/splash/splash_page.dart';
import 'package:moflu/pages/root/root_page.dart';
import 'package:moflu/pages/tab/tab_page.dart';
import 'package:flutter/material.dart';

PageJump pageJump = PageJump.sharedInstance;

void openJumpUrl(String? url) {
  if (url != null) {
    launch(url);
  }
}

Map<String, WidgetBuilder> globalRouters = {
  // TODO:add router path here
  '/debug': (context) => DebugPage(),
  '/root': (context) => RootPage(),
  '/splash': (context) => SplashPage(),
  '/advert': (context) => AdvertPage(),
  '/tab': (context) => TabPage(),
  '/home': (context) => HomePage(),
};

class Nav {
  static Future<T?> goAppSelectPage<T extends Object>() {
    return goPage('/app_select');
  }
}

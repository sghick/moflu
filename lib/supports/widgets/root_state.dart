import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rego/base_core/routes/navigators.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:moflu/supports/app/router.dart';
import 'package:moflu/supports/utils/pref_utils.dart';

extension RootPrefEx on SharedPreferences {
  /// 隐私版本号
  String get privateVersion {
    return this.getString('PRIVATE_VERSION') ?? "";
  }

  set privateVersion(String? value) =>
      this.setString('PRIVATE_VERSION', value ?? '');

  /// 闪屏版本号
  String get splashVersion {
    return this.getString('SPLASH_VERSION') ?? '';
  }

  set splashVersion(String? value) =>
      this.setString('SPLASH_VERSION', value ?? '');
}

abstract class CBRootState<T extends StatefulWidget> extends State<T> {
  bool _didShowLaunch = false;

  Widget launchPage(VoidCallback endAnimated);

  String get privateVersion => '';

  String? get privatePage => null;

  Function? get privateDialogHandler => null;

  String get splashVersion => '';

  String? get splashPage => null;

  String? get advertPage => null;

  String get homePage;

  @override
  Widget build(BuildContext context) {
    if (_didShowLaunch) {
      return Container(color: Colors.white);
    } else {
      return launchPage(() async {
        await doPrivateDialogHandler();
        _didShowLaunch = true;
        setState(() {
          goRootPage();
        });
      });
    }
  }

  Future goRootPage() async {
    await goPrivatePage();
    await goSplashPage();
    await goAdvertPage();
    return goHomePage();
  }

  Future goPrivatePage() {
    if ((privatePage != null) && (privateVersion != sharedPref.privateVersion)) {
      sharedPref.privateVersion = privateVersion;
      return goPageWithRoute(goPage(privatePage!, mode: RouteMode.CLEAR_TOP));
    }
    return Future.value();
  }

  Future doPrivateDialogHandler() {
    if ((privateDialogHandler != null) && (privateVersion != sharedPref.privateVersion)) {
      sharedPref.privateVersion = privateVersion;
      return privateDialogHandler!();
    }
    return Future.value();
  }

  Future goSplashPage() {
    if ((splashPage != null) && (splashVersion != sharedPref.splashVersion)) {
      sharedPref.splashVersion = splashVersion;
      return goPageWithRoute(goPage(splashPage!, mode: RouteMode.CLEAR_TOP));
    }
    return Future.value();
  }

  Future goAdvertPage() {
    if (advertPage != null) {
      return goPageWithRoute(goPage(advertPage!, mode: RouteMode.CLEAR_TOP));
    }
    return Future.value();
  }

  Future goHomePage() {
    return goPageWithRoute(goPage(homePage, mode: RouteMode.CLEAR_TOP));
  }
}

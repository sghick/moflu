import 'package:shared_preferences/shared_preferences.dart';

extension LoginPrefEx on SharedPreferences {
  ///登陆的手机号
  String get loginPhone {
    return this.getString('LOGIN_PHONE') ?? "";
  }

  set loginPhone(String? value) => this.setString('LOGIN_PHONE', value ?? '');

  /// 登录状态
  bool get loginStatus {
    return this.getBool('LOGIN_STATUS') ?? false;
  }

  set loginStatus(bool? value) => this.setBool('LOGIN_STATUS', value ?? false);
}

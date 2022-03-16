import 'package:rego/base_core/log/logger.dart';

Global global = Global.instance;

class Global {
  static Global? _instance;

  static Global get instance {
    if (_instance == null) {
      _instance = Global();
      logD('使用 ComponentGlobal 请务必进行初始化');
    }
    return _instance!;
  }

  late bool appReleaseMode;

  void init(bool appReleaseMode) {
    this.appReleaseMode = appReleaseMode;
    logD('ComponentGlobal 初始化完成');
  }
}

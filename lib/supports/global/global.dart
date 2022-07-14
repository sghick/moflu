import 'package:rego/base_core/log/logger.dart';

Global global = Global();

class Global {
  static final Global _instance = Global._();

  factory Global() {
    return _instance;
  }

  Global._();

  late bool appReleaseMode;

  void init(bool appReleaseMode) {
    this.appReleaseMode = appReleaseMode;
    logD('ComponentGlobal 初始化完成');
  }

  Map<String, dynamic> obj = {};
}

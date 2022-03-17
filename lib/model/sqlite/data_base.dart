import 'dart:convert';

import 'package:moflu/model/json/home.dart';
import 'package:rego/base_core/db/sqlite.dart';

export 'package:moflu/model/json/home.dart';
export 'package:rego/base_core/db/sqlite.dart';

part 'home_sqlite.dart';

DBHelper dbHelper = DBHelper();

class DBHelper extends CBSqlite {
  static final DBHelper _instance = DBHelper._();

  factory DBHelper() {
    return _instance;
  }

  DBHelper._();

  @override
  String get dbname => 'data_base.db';

  @override
  int get version => 1;

  @override
  OnDatabaseOpenFn? get onOpen => (Database db) async {
        db.execute(CBDoc.dbMapper.sqlForCreateTable());
        db.execute(CBFile.dbMapper.sqlForCreateTable());
        db.execute(CBObject.dbMapper.sqlForCreateTable());
      };
}

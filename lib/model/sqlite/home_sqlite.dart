part of 'data_base.dart';

extension HomeSqlite on DBHelper {
  // AppWatch
  Future<int> insertDoc(CBDoc doc) async {
    return database.then((db) {
      return db.insert(CBDoc.dbMapper.tableName, CBDoc.dbMapper.toDBValue!(doc),
          conflictAlgorithm: ConflictAlgorithm.replace);
    });
  }

  Future<int> deleteDoc(String id) async {
    return database.then((db) {
      return db.delete(
        CBDoc.dbMapper.tableName,
        where: '${CBDoc.idColumnName} = ?',
        whereArgs: [id],
      );
    });
  }

  Future<CBDoc?> selectDoc(String? id) async {
    return database.then((db) async {
      List<Map<String, dynamic>> maps = await db.query(
        CBDoc.dbMapper.tableName,
        where: '${CBDoc.idColumnName} = ?',
        whereArgs: [id],
      );
      if (maps.isEmpty) {
        return null;
      }
      List<CBDoc> list =
          maps.map((e) => CBDoc.dbMapper.fromDBValue!(e) as CBDoc).toList();
      return list.first;
    });
  }

  Future<List<CBDoc>?> selectDocs() async {
    return database.then((db) async {
      List<Map<String, dynamic>> maps = await db.query(
        CBDoc.dbMapper.tableName,
        orderBy: '${CBDoc.nameColumnName} DESC',
      );
      if (maps.isEmpty) {
        return null;
      }
      List<CBDoc> list =
          maps.map((e) => CBDoc.dbMapper.fromDBValue!(e) as CBDoc).toList();
      return list;
    });
  }
}

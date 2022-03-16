part of 'data_base.dart';

extension HomeSqlite on DBHelper {
  // CBDoc
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

  Future<List<CBDoc>?> selectDocs(String? docId) async {
    String where = '${CBDoc.inDocIdColumnName} is null';
    if (docId != null) {
      where = '${CBDoc.inDocIdColumnName} = \'$docId\'';
    }
    return database.then((db) async {
      List<Map<String, dynamic>> maps = await db.query(
        CBDoc.dbMapper.tableName,
        where: where,
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

  // CBFile
  Future<int> insertFile(CBFile file) async {
    return database.then((db) {
      return db.insert(
          CBFile.dbMapper.tableName, CBFile.dbMapper.toDBValue!(file),
          conflictAlgorithm: ConflictAlgorithm.replace);
    });
  }

  Future<int> deleteFile(String id) async {
    return database.then((db) {
      return db.delete(
        CBFile.dbMapper.tableName,
        where: '${CBFile.idColumnName} = ?',
        whereArgs: [id],
      );
    });
  }

  Future<CBFile?> selectFile(String? id) async {
    return database.then((db) async {
      List<Map<String, dynamic>> maps = await db.query(
        CBFile.dbMapper.tableName,
        where: '${CBFile.idColumnName} = ?',
        whereArgs: [id],
      );
      if (maps.isEmpty) {
        return null;
      }
      List<CBFile> list =
          maps.map((e) => CBFile.dbMapper.fromDBValue!(e) as CBFile).toList();
      return list.first;
    });
  }

  Future<List<CBFile>?> selectFiles(String? docId) async {
    String where = '${CBFile.inDocIdColumnName} is null';
    if (docId != null) {
      where = '${CBFile.inDocIdColumnName} = \'$docId\'';
    }
    return database.then((db) async {
      List<Map<String, dynamic>> maps = await db.query(
        CBFile.dbMapper.tableName,
        where: where,
        orderBy: '${CBFile.nameColumnName} DESC',
      );
      if (maps.isEmpty) {
        return null;
      }
      List<CBFile> list =
          maps.map((e) => CBFile.dbMapper.fromDBValue!(e) as CBFile).toList();
      return list;
    });
  }

  Future<List<dynamic>?> selectAllItems(String? docId) async {
    List<CBDoc>? docs = await selectDocs(docId);
    List<CBFile>? files = await selectFiles(docId);
    List rtn = [];
    if (docs != null && docs.isNotEmpty) {
      rtn.addAll(docs);
    }
    if (files != null && files.isNotEmpty) {
      rtn.addAll(files);
    }
    return rtn;
  }
}

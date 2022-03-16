part of 'home.dart';

CBDBMapper _$CBDocDBMapper() => CBDBMapper(
      'app_doc',
      [
        CBDBColumn(CBDBType.text, CBDoc.idColumnName, isPrimaryKey: true),
        CBDBColumn(CBDBType.integer, CBDoc.pathColumnName),
        CBDBColumn(CBDBType.text, CBDoc.nameColumnName),
        CBDBColumn(CBDBType.text, CBDoc.docIdsColumnName),
        CBDBColumn(CBDBType.text, CBDoc.fileIdsColumnName),
      ],
      fromDBValue: _$CBDocFromDBValue,
      toDBValue: _$CBDocToDBValue,
    );

CBDoc _$CBDocFromDBValue(Map<String, dynamic> map) {
  Map<String, dynamic> dbValue = {};
  map.forEach((key, value) {
    dbValue[key] = value;
  });
  dbValue[CBDoc.docIdsColumnName] == null
      ? null
      : dbValue[CBDoc.docIdsColumnName] =
          json.decode(dbValue[CBDoc.docIdsColumnName]);
  dbValue[CBDoc.fileIdsColumnName] == null
      ? null
      : dbValue[CBDoc.fileIdsColumnName] =
          json.decode(dbValue[CBDoc.fileIdsColumnName]);
  return _$CBDocFromJson(dbValue);
}

Map<String, dynamic> _$CBDocToDBValue(CBDoc instance) {
  Map<String, dynamic> map = _$CBDocToJson(instance);
  instance.docIds == null
      ? null
      : map[CBDoc.docIdsColumnName] = json.encode(instance.docIds);
  instance.fileIds == null
      ? null
      : map[CBDoc.fileIdsColumnName] = json.encode(instance.fileIds);
  return map;
}

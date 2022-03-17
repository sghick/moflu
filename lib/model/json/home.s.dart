part of 'home.dart';

CBDBMapper _$CBDocDBMapper() => CBDBMapper(
      'app_doc',
      [
        CBDBColumn(CBDBType.text, CBDoc.idColumnName, isPrimaryKey: true),
        CBDBColumn(CBDBType.text, CBDoc.inDocIdColumnName),
        CBDBColumn(CBDBType.integer, CBDoc.pathColumnName),
        CBDBColumn(CBDBType.text, CBDoc.nameColumnName),
      ],
      toDBValue: _$CBDocToJson,
      fromDBValue: _$CBDocFromJson,
    );

CBDBMapper _$CBFileDBMapper() => CBDBMapper(
      'app_file',
      [
        CBDBColumn(CBDBType.text, CBFile.idColumnName, isPrimaryKey: true),
        CBDBColumn(CBDBType.text, CBFile.inDocIdColumnName),
        CBDBColumn(CBDBType.integer, CBFile.pathColumnName),
        CBDBColumn(CBDBType.text, CBFile.nameColumnName),
      ],
      toDBValue: _$CBFileToJson,
      fromDBValue: _$CBFileFromJson,
    );

CBDBMapper _$CBObjectDBMapper() => CBDBMapper(
      'app_object',
      [
        CBDBColumn(CBDBType.text, CBObject.idColumnName, isPrimaryKey: true),
        CBDBColumn(CBDBType.text, CBObject.inFileIdColumnName),
      ],
      toDBValue: _$CBObjectToJson,
      fromDBValue: _$CBObjectFromJson,
    );

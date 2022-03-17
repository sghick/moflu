import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:moflu/model/annotation/json_annotation.dart';
import 'package:rego/base_core/db/sqlite.dart';
import 'package:uuid/uuid.dart';

part 'home.g.dart';

part 'home.s.dart';

// static Future<CBDoc> fromJsonFile() {
//   return rootBundle.loadString('assets/files/apps.json').then((value) {
//     return CBDoc.fromJson(json.decode(value));
//   });
// }

@JsonModel()
class CBDoc extends JsonConvert {
  String id;
  String? inDocId;
  String name;
  String? path;

  static String idColumnName = 'id';
  static String inDocIdColumnName = 'in_doc_id';
  static String nameColumnName = 'name';
  static String pathColumnName = 'path';

  CBDoc(this.id, this.inDocId, this.name, this.path);

  CBDoc.fromCreate(String name, String? inDocId)
      : this.id = Uuid().v5(null, name),
        this.name = name,
        this.inDocId = inDocId;

  @override
  Map<String, dynamic> toJson() => _$CBDocToJson(this);

  factory CBDoc.fromJson(json) => _$CBDocFromJson(json);

  static CBDBMapper get dbMapper => _$CBDocDBMapper();
}

@JsonModel()
class CBFile extends JsonConvert {
  String id;
  String? inDocId;
  String name;
  String? path;

  CBFile(this.id, this.inDocId, this.name, this.path);

  static String idColumnName = 'id';
  static String inDocIdColumnName = 'in_doc_id';
  static String nameColumnName = 'name';
  static String pathColumnName = 'path';

  CBFile.fromCreate(String name, String? inDocId)
      : this.id = Uuid().v5(null, name),
        this.name = name,
        this.inDocId = inDocId;

  @override
  Map<String, dynamic> toJson() => _$CBFileToJson(this);

  factory CBFile.fromJson(json) => _$CBFileFromJson(json);

  static CBDBMapper get dbMapper => _$CBFileDBMapper();
}

@JsonModel()
class CBObject extends JsonConvert {
  String id;
  String? inFileId;

  static String idColumnName = 'id';
  static String inFileIdColumnName = 'in_file_id';

  CBObject(this.id, this.inFileId);

  CBObject.fromCreate(String inFileId)
      : this.id = Uuid().v1(),
        this.inFileId = inFileId;

  @override
  Map<String, dynamic> toJson() => _$CBObjectToJson(this);

  factory CBObject.fromJson(json) => _$CBObjectFromJson(json);

  static CBDBMapper get dbMapper => _$CBObjectDBMapper();
}

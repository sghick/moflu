import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:moflu/model/annotation/json_annotation.dart';
import 'package:rego/base_core/db/sqlite.dart';

part 'home.g.dart';

part 'home.s.dart';

// static Future<CBDoc> fromJsonFile() {
//   return rootBundle.loadString('assets/files/apps.json').then((value) {
//     return CBDoc.fromJson(json.decode(value));
//   });
// }

@JsonModel()
class CBDoc extends JsonConvert {
  final String? id;
  final String? name;
  final String? path;
  final List<String>? docIds;
  final List<String>? fileIds;

  static String idColumnName = 'id';
  static String nameColumnName = 'name';
  static String pathColumnName = 'path';
  static String docIdsColumnName = 'doc_ids';
  static String fileIdsColumnName = 'file_ids';

  CBDoc(this.id, this.name, this.path, this.docIds, this.fileIds);


  @override
  Map<String, dynamic> toJson() => _$CBDocToJson(this);

  factory CBDoc.fromJson(json) => _$CBDocFromJson(json);

  static CBDBMapper get dbMapper => _$CBDocDBMapper();
}

@JsonModel()
class CBFile extends JsonConvert {
  final String? id;
  final CBObject? object;

  CBFile(this.id, this.object);

  @override
  Map<String, dynamic> toJson() => _$CBFileToJson(this);

  factory CBFile.fromJson(json) => _$CBFileFromJson(json);
}

@JsonModel()
class CBObject extends JsonConvert {
  final String? id;

  CBObject(this.id);

  @override
  Map<String, dynamic> toJson() => _$CBObjectToJson(this);

  factory CBObject.fromJson(json) => _$CBObjectFromJson(json);
}

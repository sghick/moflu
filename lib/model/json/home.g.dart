// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CBDoc _$CBDocFromJson(Map<String, dynamic> json) => CBDoc(
      json['id'] as String,
      json['in_doc_id'] as String?,
      json['name'] as String,
      json['path'] as String?,
    );

Map<String, dynamic> _$CBDocToJson(CBDoc instance) => <String, dynamic>{
      'id': instance.id,
      'in_doc_id': instance.inDocId,
      'name': instance.name,
      'path': instance.path,
    };

CBFile _$CBFileFromJson(Map<String, dynamic> json) => CBFile(
      json['id'] as String,
      json['in_doc_id'] as String?,
      json['name'] as String,
      json['path'] as String?,
    );

Map<String, dynamic> _$CBFileToJson(CBFile instance) => <String, dynamic>{
      'id': instance.id,
      'in_doc_id': instance.inDocId,
      'name': instance.name,
      'path': instance.path,
    };

CBObject _$CBObjectFromJson(Map<String, dynamic> json) => CBObject(
      json['id'] as String,
      json['in_file_id'] as String?,
    );

Map<String, dynamic> _$CBObjectToJson(CBObject instance) => <String, dynamic>{
      'id': instance.id,
      'in_file_id': instance.inFileId,
    };

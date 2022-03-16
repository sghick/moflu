// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CBDoc _$CBDocFromJson(Map<String, dynamic> json) => CBDoc(
      json['id'] as String?,
      json['name'] as String?,
      json['path'] as String?,
      (json['doc_ids'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['file_ids'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$CBDocToJson(CBDoc instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'path': instance.path,
      'doc_ids': instance.docIds,
      'file_ids': instance.fileIds,
    };

CBFile _$CBFileFromJson(Map<String, dynamic> json) => CBFile(
      json['id'] as String?,
      json['object'] == null ? null : CBObject.fromJson(json['object']),
    );

Map<String, dynamic> _$CBFileToJson(CBFile instance) => <String, dynamic>{
      'id': instance.id,
      'object': instance.object,
    };

CBObject _$CBObjectFromJson(Map<String, dynamic> json) => CBObject(
      json['id'] as String?,
    );

Map<String, dynamic> _$CBObjectToJson(CBObject instance) => <String, dynamic>{
      'id': instance.id,
    };

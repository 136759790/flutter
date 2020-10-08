// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Project _$ProjectFromJson(Map<String, dynamic> json) {
  return Project()
    ..id = json['id'] as int
    ..name = json['name'] as String
    ..ctime =
        json['ctime'] == null ? null : DateTime.parse(json['ctime'] as String);
}

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'ctime': instance.ctime?.toIso8601String(),
    };

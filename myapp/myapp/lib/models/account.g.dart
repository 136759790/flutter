// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) {
  return Account()
    ..id = json['id'] as int
    ..ctime = json['ctime'] as int
    ..icon_id = json['icon_id'] as int
    ..remark = json['remark'] as String
    ..value = json['value'] as num
    ..project_id = json['project_id'] as int;
}

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'id': instance.id,
      'ctime': instance.ctime,
      'icon_id': instance.icon_id,
      'remark': instance.remark,
      'value': instance.value,
      'project_id': instance.project_id,
    };

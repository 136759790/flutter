// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HairConsumeRecord _$HairConsumeRecordFromJson(Map<String, dynamic> json) {
  return HairConsumeRecord()
    ..id = json['id'] as int
    ..ctime = json['ctime'] as int
    ..creator = json['creator'] as int
    ..shop_id = json['shop_id'] as int
    ..vip_id = json['vip_id'] as int
    ..card_id = json['card_id'] as int
    ..remark = json['remark'] as String
    ..status = json['status'] as int;
}

Map<String, dynamic> _$HairConsumeRecordToJson(HairConsumeRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ctime': instance.ctime,
      'creator': instance.creator,
      'shop_id': instance.shop_id,
      'vip_id': instance.vip_id,
      'card_id': instance.card_id,
      'remark': instance.remark,
      'status': instance.status,
    };

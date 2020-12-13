// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vip.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Vip _$VipFromJson(Map<String, dynamic> json) {
  return Vip()
    ..isShowSuspension = json['isShowSuspension'] as bool
    ..id = json['id'] as int
    ..shop_id = json['shop_id'] as int
    ..name = json['name'] as String
    ..first_name = json['first_name'] as String
    ..phone = json['phone'] as String
    ..ctime = json['ctime'] as int
    ..creator = json['creator'] as int;
}

Map<String, dynamic> _$VipToJson(Vip instance) => <String, dynamic>{
      'isShowSuspension': instance.isShowSuspension,
      'id': instance.id,
      'shop_id': instance.shop_id,
      'name': instance.name,
      'first_name': instance.first_name,
      'phone': instance.phone,
      'ctime': instance.ctime,
      'creator': instance.creator,
    };

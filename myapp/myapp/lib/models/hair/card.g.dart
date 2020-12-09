// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HairCard _$HairCardFromJson(Map<String, dynamic> json) {
  return HairCard()
    ..id = json['id'] as int
    ..shop_id = json['shop_id'] as int
    ..vip_id = json['vip_id'] as int
    ..set_id = json['set_id'] as int
    ..ctime = json['ctime'] as int
    ..residue_time = json['residue_time'] as int
    ..creator = json['creator'] as int
    ..time = json['time'] as int
    ..price = json['price'] as int
    ..expire = json['expire'] as int
    ..name = json['name'] as String
    ..description = json['description'] as String
    ..vip = json['vip'] == null
        ? null
        : Vip.fromJson(json['vip'] as Map<String, dynamic>);
}

Map<String, dynamic> _$HairCardToJson(HairCard instance) => <String, dynamic>{
      'id': instance.id,
      'shop_id': instance.shop_id,
      'vip_id': instance.vip_id,
      'set_id': instance.set_id,
      'ctime': instance.ctime,
      'residue_time': instance.residue_time,
      'creator': instance.creator,
      'time': instance.time,
      'price': instance.price,
      'expire': instance.expire,
      'name': instance.name,
      'description': instance.description,
      'vip': instance.vip,
    };

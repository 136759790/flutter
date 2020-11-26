// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Set _$SetFromJson(Map<String, dynamic> json) {
  return Set(
    json['creator'] as int,
    json['description'] as String,
    json['id'] as int,
    json['name'] as String,
    json['price'] as int,
    json['shop_id'] as int,
    json['time'] as int,
  )
    ..ctime = json['ctime'] as int
    ..order_no = json['order_no'] as int
    ..valid = json['valid'] as int;
}

Map<String, dynamic> _$SetToJson(Set instance) => <String, dynamic>{
      'id': instance.id,
      'shop_id': instance.shop_id,
      'ctime': instance.ctime,
      'creator': instance.creator,
      'price': instance.price,
      'time': instance.time,
      'order_no': instance.order_no,
      'valid': instance.valid,
      'name': instance.name,
      'description': instance.description,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Shop _$ShopFromJson(Map<String, dynamic> json) {
  return Shop()
    ..id = json['id'] as int
    ..name = json['name'] as String
    ..ctime = json['ctime'] as int
    ..creator = json['creator'] as int;
}

Map<String, dynamic> _$ShopToJson(Shop instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'ctime': instance.ctime,
      'creator': instance.creator,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Shop _$ShopFromJson(Map<String, dynamic> json) {
  return Shop()
    ..id = json['id'] as int
    ..name = json['name'] as String
    ..ctime =
        json['ctime'] == null ? null : DateTime.parse(json['ctime'] as String);
}

Map<String, dynamic> _$ShopToJson(Shop instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'ctime': instance.ctime?.toIso8601String(),
    };

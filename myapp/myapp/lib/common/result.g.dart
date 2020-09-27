// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Result _$ResultFromJson(Map<String, dynamic> json) {
  return Result()
    ..code = json['code'] as int
    ..data = json['data'] as Map<String, dynamic>
    ..msg = json['msg'] as String
    ..msgDetail = json['msgDetail'] as String
    ..status = json['status'] as int;
}

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
      'msg': instance.msg,
      'msgDetail': instance.msgDetail,
      'status': instance.status,
    };

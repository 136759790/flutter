// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..id = json['id'] as int
    ..account = json['account'] as String
    ..nickname = json['nickname'] as String
    ..email = json['email'] as String
    ..phone = json['phone'] as String
    ..introduction = json['introduction'] as String
    ..password = json['password'] as String
    ..name = json['name'] as String
    ..roles = (json['roles'] as List)?.map((e) => e as String)?.toList()
    ..ress = (json['ress'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'account': instance.account,
      'nickname': instance.nickname,
      'email': instance.email,
      'phone': instance.phone,
      'introduction': instance.introduction,
      'password': instance.password,
      'name': instance.name,
      'roles': instance.roles,
      'ress': instance.ress,
    };

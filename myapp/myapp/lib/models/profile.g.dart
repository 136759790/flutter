// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) {
  return Profile(
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    theme: json['theme'] as int,
    lastLogin: json['lastLogin'] as String,
    locale: json['locale'] as String,
    token: json['token'] as String,
  );
}

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'user': instance.user,
      'token': instance.token,
      'lastLogin': instance.lastLogin,
      'locale': instance.locale,
      'theme': instance.theme,
    };
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accountGroup.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountGroup _$AccountGroupFromJson(Map<String, dynamic> json) {
  return AccountGroup()
    ..date = json['date'] as String
    ..week = json['week'] as String
    ..income = (json['income'] as num)?.toDouble()
    ..expense = (json['expense'] as num)?.toDouble()
    ..accounts = (json['accounts'] as List)
        ?.map((e) =>
            e == null ? null : Account.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$AccountGroupToJson(AccountGroup instance) =>
    <String, dynamic>{
      'date': instance.date,
      'week': instance.week,
      'income': instance.income,
      'expense': instance.expense,
      'accounts': instance.accounts,
    };

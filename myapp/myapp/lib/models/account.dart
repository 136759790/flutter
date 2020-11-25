import 'package:json_annotation/json_annotation.dart';

part 'account.g.dart';

@JsonSerializable(nullable: false)
class Account {
  int id;
  int ctime;
  int icon_id;
  String remark;
  num value;
  int project_id;
  Account();

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);
  Map<String, dynamic> toJson() => _$AccountToJson(this);
}

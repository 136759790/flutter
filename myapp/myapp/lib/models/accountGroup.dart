import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';
import 'package:myapp/models/account.dart';

part 'accountGroup.g.dart';

@JsonSerializable()
class AccountGroup {
  String date;
  String week;
  double income = 0;
  double expense = 0;
  List<Account> accounts = [];
  AccountGroup();
  static AccountGroup init(String sdate, int weekday) {
    AccountGroup ag = new AccountGroup();
    ag.date = sdate;
    var weeks = ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"];
    ag.week = weeks[weekday];
    return ag;
  }

  void addAcc(Account acc) {
    accounts.add(acc);
  }

  factory AccountGroup.fromJson(Map<String, dynamic> json) =>
      _$AccountGroupFromJson(json);
  Map<String, dynamic> toJson() => _$AccountGroupToJson(this);
}

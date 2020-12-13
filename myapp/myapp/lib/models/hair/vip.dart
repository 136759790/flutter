import 'package:azlistview/azlistview.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vip.g.dart';

@JsonSerializable()
class Vip extends ISuspensionBean {
  int id;
  int shop_id;
  String name;
  String first_name;
  String phone;
  int ctime;
  int creator;
  Vip();

  factory Vip.fromJson(Map<String, dynamic> json) => _$VipFromJson(json);
  Map<String, dynamic> toJson() => _$VipToJson(this);

  @override
  String getSuspensionTag() => first_name;

  @override
  bool get isShowSuspension => true;
}

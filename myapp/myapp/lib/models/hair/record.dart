import 'package:json_annotation/json_annotation.dart';

part 'record.g.dart';

@JsonSerializable()
class HairConsumeRecord {
  int id;
  int ctime;
  int creator;
  int shop_id;
  int vip_id;
  int card_id;
  String remark;
  int status;
  HairConsumeRecord();

  factory HairConsumeRecord.fromJson(Map<String, dynamic> json) =>
      _$HairConsumeRecordFromJson(json);
  Map<String, dynamic> toJson() => _$HairConsumeRecordToJson(this);
}

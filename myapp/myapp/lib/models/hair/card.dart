import 'package:json_annotation/json_annotation.dart';
import 'package:myapp/models/hair/vip.dart';

part 'card.g.dart';

@JsonSerializable()
class HairCard {
  int id;
  int shop_id;
  int vip_id;
  int set_id;
  int ctime;
  int residue_time;
  int creator;
  int time;
  int price;
  int expire;
  String name;
  String description;
  Vip vip;
  HairCard();
  factory HairCard.fromJson(Map<String, dynamic> json) =>
      _$HairCardFromJson(json);
  Map<String, dynamic> toJson() => _$HairCardToJson(this);
}

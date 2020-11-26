import 'package:json_annotation/json_annotation.dart';

part 'set.g.dart';

@JsonSerializable()
class Set {
  int id;
  int shop_id;
  int ctime;
  int creator;
  int price;
  int time;
  int order_no;
  int valid;
  String name;
  String description;
  Set(this.creator, this.description, this.id, this.name, this.price,
      this.shop_id, this.time);

  factory Set.fromJson(Map<String, dynamic> json) => _$SetFromJson(json);
  Map<String, dynamic> toJson() => _$SetToJson(this);
}

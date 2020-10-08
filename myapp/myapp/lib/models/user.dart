import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  int id;
  String account;
  String nickname;
  String email;
  String phone;
  String introduction;
  String password;
  String name;
  List<String> roles;
  List<String> ress;

  User(this.account, this.password);
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

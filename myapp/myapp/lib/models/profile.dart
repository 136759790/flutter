import 'package:json_annotation/json_annotation.dart';
import 'package:myapp/models/user.dart';

part 'profile.g.dart';

@JsonSerializable()
class Profile {
  User user;
  String token, lastLogin, locale;
  int theme;
  Profile({this.user, this.theme, this.lastLogin, this.locale, this.token});
  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}

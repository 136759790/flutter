import 'package:json_annotation/json_annotation.dart';

part 'result.g.dart';

@JsonSerializable()
class Result {
  int code;
  var data;
  String msg, msgDetail;
  int status;
  Result(this.data);

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);
  Map<String, dynamic> toJson() => _$ResultToJson(this);

  @override
  String toString() {
    return this.toJson().toString();
  }
}

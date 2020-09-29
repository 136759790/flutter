import 'package:dio/dio.dart';
import 'package:myapp/common/http.dart';
import 'package:myapp/common/result.dart';

void main() async {
  var http = new Http();
  Result data = await http
      .post('user/login', data: {'username': 'qxq', 'password': '111111'});
  print(data.toString());
}

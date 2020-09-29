import 'package:dio/dio.dart';
import 'package:myapp/common/http.dart';
import 'package:myapp/common/result.dart';

class UserApi {
  static Future<bool> isLogin() async {
    Result res = await $.get('sys/isLogin');
    return res.data;
  }

  static Future<Result> login(username, password) async {
    Result res = await $
        .post('user/login', data: {'username': username, 'password': password});
    return res;
  }
}

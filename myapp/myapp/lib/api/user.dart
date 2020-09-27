import 'package:dio/dio.dart';
import 'package:myapp/common/api.dart';
import 'package:myapp/common/result.dart';

class UserApi {
  static Future<bool> isLogin() async {
    Response res = await Api.api.get('sys/isLogin');
    Map data = new Map<String, dynamic>.from(res.data);
    return data['data'];
  }

  static Future<bool> login(username, password) async {
    Response<Map<String, dynamic>> res =
        await Api.api.post('user/login', data: {username, password});
    Map data = new Map<String, dynamic>.from(res.data);
    return false;
  }
}

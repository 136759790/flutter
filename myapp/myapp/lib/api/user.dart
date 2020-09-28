import 'package:dio/dio.dart';
import 'package:myapp/common/http.dart';
import 'package:myapp/common/result.dart';

class UserApi {
  static Future<bool> isLogin() async {
    Response res = await dio.get('sys/isLogin');
    return res.data['data'];
  }

  static Future<Result> login(username, password) async {
    Map data = new Map();
    data['username'] = username;
    data['password'] = password;
    Response res = await dio.post('user/login', data: data);
    print(res);
    Result result = Result.fromJson(res.data);
    return result;
  }
}

import 'package:dio/dio.dart';
import 'package:myapp/common/global.dart';

class Api {
  static BaseOptions options = new BaseOptions(
      contentType: "stream",
      baseUrl: 'http://api.grelove.com/',
      connectTimeout: 5000,
      receiveTimeout: 5000,
      headers: {"Cookie": Global.cookie});
  static Dio api = new Dio(options);
  static Dio apiOrg = new Dio();
}

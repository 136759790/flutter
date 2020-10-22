import 'package:dio/dio.dart';
import 'package:yskc/common/result.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

var $ = Http();
var $baidu = new Dio(new BaseOptions(
    responseType: ResponseType.json,
    contentType: Headers.formUrlEncodedContentType,
    connectTimeout: 50000,
    receiveTimeout: 50000));

class Http {
  var cookieJar = CookieJar();
  var dio = new Dio(new BaseOptions(
      responseType: ResponseType.json,
      contentType: Headers.jsonContentType,
      baseUrl: 'http://api.grelove.com/',
      connectTimeout: 5000,
      receiveTimeout: 5000));
  Future<Result> get(String path, {Map<String, dynamic> params}) async {
    Response res = await dio.get(path);
    return Result.fromJson(res.data);
  }

  Future<Result> post(String path, {Map data}) async {
    Response res = await dio.post(path, data: data);
    print(res.headers.toString());
    return Result.fromJson(res.data);
  }

  Http() {
    this.dio.interceptors.add(CookieManager(cookieJar));
    this
        .dio
        .interceptors
        .add(LogInterceptor(responseHeader: false, responseBody: true));
  }
}
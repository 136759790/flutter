import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myapp/common/global.dart';
import 'package:myapp/common/result.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

var $ = Http();
var $baidu = new Dio(new BaseOptions(
    responseType: ResponseType.json,
    contentType: Headers.formUrlEncodedContentType,
    connectTimeout: 50000,
    receiveTimeout: 50000));

class Http {
  CancelToken cancelToken = CancelToken();
  var cookieJar = CookieJar();
  var dio = new Dio(new BaseOptions(
      responseType: ResponseType.json,
      contentType: Headers.jsonContentType,
      baseUrl: 'https://api.grelove.com/',
      connectTimeout: 5000,
      receiveTimeout: 5000));
  Future<Result> get(String path, {Map<String, dynamic> params}) async {
    Response res = await dio.get(path, cancelToken: cancelToken);
    return Result.fromJson(res.data);
  }

  Future<Result> post(String path, {Map data}) async {
    Response res = await dio.post(path, data: data, cancelToken: cancelToken);
    return Result.fromJson(res.data);
  }

  Http() {
    this.dio.interceptors.add(CookieManager(cookieJar));
    this
        .dio
        .interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
          print('-----------------------------${options.path}');
        }, onResponse: (Response res) async {
          int status = res.data['status'];
          if (status != 1) {
            String msgDetail = "${res.data['msgDetail']}";
            Fluttertoast.cancel();
            Fluttertoast.showToast(msg: msgDetail);
          }
          // dio.lock();
          // dio.clear();
          print('++++++++++++++++++++++++++++++$res');
        }, onError: (DioError err) {
          print('++++++++++++++++++++++++++++++$err');
          switch (err.type) {
            case DioErrorType.RESPONSE:
              if (err.response != null && err.response.statusCode == 401) {
                print('++++++++++++12312312++++++++++++++++++$err');
                Global.navigatorKey.currentState
                    .pushNamedAndRemoveUntil('login', (route) => route == null);
              } else {
                Global.navigatorKey.currentState
                    .pushNamedAndRemoveUntil('error', (route) => route == null);
              }
              break;
            case DioErrorType.CONNECT_TIMEOUT:
              Fluttertoast.showToast(msg: '请求超时，请检查网络(001)');
              Global.navigatorKey.currentState
                  .pushNamedAndRemoveUntil('error', (route) => route == null);
              break;
            case DioErrorType.RECEIVE_TIMEOUT:
              Fluttertoast.showToast(msg: '请求超时，请检查网络(002)');
              break;
            case DioErrorType.SEND_TIMEOUT:
              Fluttertoast.showToast(msg: '请求超时，请检查网络(003)');
              break;
            default:
              Global.navigatorKey.currentState
                  .pushNamedAndRemoveUntil('error', (route) => route == null);
          }
        }));
  }
}

import 'package:myapp/common/result.dart';

class Util {
  static bool isOk(Result result) {
    return result.status == 1;
  }
}

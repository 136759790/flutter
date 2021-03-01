import 'package:yskc/common/result.dart';

class Util {
  static bool isOk(Result result) {
    return result.status == 1;
  }
}

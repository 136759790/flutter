import '../common/http.dart';
import '../common/result.dart';

class TruckApi {
  static Future page(Map data) async {
    Result res = await $.post('truck/page', data: data);
    return res.data;
  }
}

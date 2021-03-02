import 'package:yskc/common/http.dart';
import 'package:yskc/common/result.dart';

class TruckApi {
  static Future page(data) async {
    Result res = await $.post('truck/page', data: data);
    List list = res.data['list'];
    res.data['list'] = list.map((e) => Map.from(e)).toList();
    return Map.from(res.data);
  }
}

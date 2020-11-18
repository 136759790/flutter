import 'package:myapp/common/http.dart';
import 'package:myapp/common/result.dart';

class HairApi {
  static Future saveShop(var shop) async {
    Result res = await $.post('shop/save', data: shop);
    return res.data;
  }
}

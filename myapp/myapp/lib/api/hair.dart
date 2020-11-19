import 'package:myapp/common/http.dart';
import 'package:myapp/common/result.dart';

class HairApi {
  static Future saveShop(var shop) async {
    Result res = await $.post('hair/shop/save', data: shop);
    return res.data;
  }

  static Future getShops(var data) async {
    Result res = await $.post('hair/shop/page', data: data);
    return res.data;
  }
}

import 'package:myapp/common/http.dart';
import 'package:myapp/common/result.dart';
import 'package:myapp/models/shop.dart';
import 'package:retrofit/retrofit.dart';

class HairApi {
  static Future saveShop(var shop) async {
    Result res = await $.post('hair/shop/save', data: shop);
    return res.data;
  }

  static Future getShops(var data) async {
    Result res = await $.post('hair/shop/page', data: data);
    return res.data;
  }

  static Future<Shop> getShop(int id) async {
    Result res = await $.get('hair/shop/$id');
    return Shop.fromJson(res.data);
  }
}

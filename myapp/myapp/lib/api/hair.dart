import 'package:myapp/common/http.dart';
import 'package:myapp/common/result.dart';
import 'package:myapp/models/hair/set.dart';
import 'package:myapp/models/shop.dart';

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

  static Future<List<Set>> getSets(Map data) async {
    Result res = await $.post('hair/sets', data: data);
    List<Set> sets = [];
    for (var item in res.data) {
      sets.add(Set.fromJson(new Map.from(item)));
    }
    return sets;
  }

  static Future saveSet(var set) async {
    Result res = await $.post('hair/set/save', data: set);
    return res;
  }
}

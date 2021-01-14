import 'dart:convert';

import 'package:myapp/common/Page.dart';
import 'package:myapp/common/http.dart';
import 'package:myapp/common/result.dart';
import 'package:myapp/models/hair/card.dart';
import 'package:myapp/models/hair/record.dart';
import 'package:myapp/models/hair/set.dart';
import 'package:myapp/models/hair/vip.dart';
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

  static Future saveVip(var vip) async {
    Result res = await $.post('hair/vip/save', data: vip);
    return res;
  }

  static Future deleteVip(var id) async {
    Result res = await $.post('hair/vip/delete?id=$id');
    return res;
  }

  static Future<PageInfo> pageVip(var data) async {
    Result res = await $.post('hair/vip/page', data: data);
    PageInfo vips = PageInfo.fromJson(res.data);
    return vips;
  }

  static Future<List<Vip>> getVips(var data) async {
    Result res = await $.post('hair/vips', data: data);
    List<Vip> vips = List.from(res.data.map((e) => Vip.fromJson(Map.from(e))));
    return vips;
  }

  static Future<Vip> getVip(id) async {
    Result res = await $.get('hair/vip/$id');
    Vip vip = Vip.fromJson(res.data);
    return vip;
  }

  static Future saveCard(var card) async {
    Result res = await $.post('hair/card/save', data: card);
    return res;
  }

  static Future<PageInfo> getCards(var data) async {
    Result res = await $.post('hair/cards', data: data);
    PageInfo cards = PageInfo.fromJson(res.data);
    return cards;
  }

  static Future<HairCard> getCard(int id) async {
    Result res = await $.get('hair/card/$id');
    HairCard card = HairCard.fromJson(res.data);
    return card;
  }

  static Future consumeCard(data) async {
    Result res = await $.post('hair/card/consume', data: data);
    return res;
  }

  static Future rollbackRecord(int id) async {
    Result res = await $.post('hair/card/consume/$id');
    return res;
  }

  static Future<List<HairConsumeRecord>> getRecords(int card_id) async {
    List<HairConsumeRecord> records = [];
    Result res = await $.get('hair/card/consume/records?card_id=$card_id');
    if (res.data.length > 0) {
      res.data.forEach((i) => {records.add(HairConsumeRecord.fromJson(i))});
    }
    return records;
  }
}

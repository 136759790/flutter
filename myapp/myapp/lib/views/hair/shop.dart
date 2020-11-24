import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/api/hair.dart';
import 'package:myapp/views/hair/shop_edit.dart';
import 'package:myapp/views/hair/shop_search.dart';

class HairShop extends StatefulWidget {
  HairShop({Key key}) : super(key: key);

  @override
  _HairShopState createState() => _HairShopState();
}

class _HairShopState extends State<HairShop> {
  List _shops = [];
  @override
  void initState() {
    super.initState();
    HairApi.getShops({}).then((value) {
      print('value------${value['list']}');
      if (value != null && value['list'].length > 0) {
        List shops = [];
        for (var item in value['list']) {
          shops.add(new Map.from(item));
        }
        setState(() {
          _shops = shops;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_shops.length == 0) {
      return Scaffold(
        appBar: AppBar(
          title: Text('添加店铺'),
          centerTitle: true,
        ),
        body: Center(
            child: Padding(
          padding: const EdgeInsets.all(44.0),
          child: FlatButton.icon(
              color: Colors.blue,
              onPressed: () {
                Navigator.of(context).push(
                    new MaterialPageRoute(builder: (context) => ShopEdit()));
              },
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              label: Text(
                '添加店铺',
                style: TextStyle(color: Colors.white),
              )),
        )),
      );
    } else {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('商铺'),
          actions: [
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  showSearch(context: context, delegate: SearchBarShop());
                })
          ],
        ),
        body: _body(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          heroTag: "addCard",
        ),
      );
    }
  }

  Widget _body() {
    return Column(
      children: [
        Expanded(
            child: Row(
          children: [
            Expanded(
                child: Card(
              child: ListTile(
                title: Text('会员卡数量'),
                subtitle: Text('103'),
              ),
            )),
            Expanded(
                child: Card(
              child: ListTile(
                title: Text('今日新增'),
                subtitle: Text('7'),
              ),
            )),
          ],
        )),
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverSafeArea(
                  sliver: SliverPadding(
                padding: EdgeInsets.all(8),
                sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                  return Column(children: [
                    ListTile(
                      // dense: true,
                      title: Text("赵晓腾  13699298074"),
                      trailing: Text('剩余6次'),
                    ),
                    Divider()
                  ]);
                }, childCount: 10)),
              ))
            ],
          ),
          flex: 5,
        )
      ],
    );
  }
}

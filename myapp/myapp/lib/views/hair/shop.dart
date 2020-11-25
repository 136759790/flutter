import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/api/hair.dart';
import 'package:myapp/views/hair/card_edit.dart';
import 'package:myapp/views/hair/shop_edit.dart';
import 'package:myapp/views/hair/shop_search.dart';

class HairShop extends StatefulWidget {
  HairShop({Key key}) : super(key: key);

  @override
  _HairShopState createState() => _HairShopState();
}

class _HairShopState extends State<HairShop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('商铺'),
        centerTitle: true,
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
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ShopCard()));
        },
        heroTag: "addCard",
      ),
    );
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

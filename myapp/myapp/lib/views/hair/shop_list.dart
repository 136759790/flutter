import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:myapp/api/hair.dart';
import 'package:myapp/common/notifier.dart';
import 'package:myapp/models/shop.dart';
import 'package:myapp/views/hair/shop.dart';
import 'package:myapp/views/hair/shop_edit.dart';
import 'package:provider/provider.dart';

class ShopList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ShopListState();
}

class ShopListState extends State<ShopList> {
  Future _getData() async {
    return HairApi.getShops({});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('店铺列表'),
          centerTitle: true,
          actions: [
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => ShopEdit()))
                      .then((value) {
                    if (true) {
                      setState(() {});
                    }
                  });
                })
          ],
        ),
        body: FutureBuilder(
          future: _getData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var res = snapshot.data;
              List shops = res['list'];
              bool _hasShop = shops.length > 0;
              List<Shop> shopList = shops.map((e) => Shop.fromJson(e)).toList();
              Shop shopModel = Provider.of<ShopModel>(context).shop;
              return _hasShop ? _shopListView(shopList, shopModel) : _addShop();
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }

  Widget _addShop() {
    return Center(
        child: Padding(
            padding: const EdgeInsets.all(44.0),
            child: RaisedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(new MaterialPageRoute(
                          builder: (context) => ShopEdit()))
                      .then((value) {
                    if (true) {
                      setState(() {});
                    }
                  });
                },
                child: Text('暂无店铺，点击添加'))));
  }

  Widget _shopListView(List<Shop> shopList, Shop shopModel) {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(),
      itemCount: shopList.length,
      itemBuilder: (BuildContext context, int index) {
        Shop shop = shopList[index];
        bool _selected = shopModel != null && shopModel.id == shop.id;
        return ListTile(
          dense: true,
          onTap: () {
            showDialog(
                context: context,
                child: AlertDialog(
                  title: Text('提示'),
                  content: Text('要切换到项目【${shop.name}】?'),
                  actions: [
                    FlatButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: Text('取消')),
                    FlatButton(
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      child: Text('确定'),
                    ),
                  ],
                )).then((value) {
              if (value) {
                Provider.of<ShopModel>(context, listen: false).shop = shop;
                Navigator.of(context).pop(true);
              }
            });
          },
          leading: Icon(_selected
              ? Icons.radio_button_checked
              : Icons.radio_button_unchecked),
          selected: _selected,
          title: Text(shop.name),
          trailing: IconButton(
              icon: Icon(Icons.keyboard_arrow_right),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(
                        builder: (context) => ShopEdit(id: shop.id)))
                    .then((value) {});
              }),
        );
      },
    );
  }
}

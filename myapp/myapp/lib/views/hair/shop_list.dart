import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myapp/api/hair.dart';
import 'package:myapp/common/dialog/util.dart';
import 'package:myapp/common/notifier.dart';
import 'package:myapp/common/route.dart';
import 'package:myapp/models/shop.dart';
import 'package:myapp/routes/home.dart';
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
                color: Theme.of(context).primaryColor,
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
                child: Text(
                  '请先设置店铺',
                ))));
  }

  Widget _shopListView(List<Shop> shopList, Shop shopModel) {
    return Container(
      padding: EdgeInsets.all(10),
      child: ListView.separated(
        separatorBuilder: (context, index) => Divider(),
        itemCount: shopList.length,
        itemBuilder: (BuildContext context, int index) {
          Shop shop = shopList[index];
          bool _selected = shopModel != null && shopModel.id == shop.id;
          return ListTile(
            dense: true,
            onTap: () {
              UtilDialog.showDialog(context, '确认要切换到${shop.name}店铺吗？')
                  .then((value) {
                if (value) {
                  Provider.of<ShopModel>(context, listen: false).shop = shop;
                  Rt.toDelay(context, HomePage());
                }
              });
            },
            leading: Icon(Icons.home_filled),
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
      ),
    );
  }
}

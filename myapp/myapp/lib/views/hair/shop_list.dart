import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:myapp/api/hair.dart';
import 'package:myapp/common/notifier.dart';
import 'package:myapp/models/shop.dart';
import 'package:myapp/views/hair/shop_edit.dart';
import 'package:provider/provider.dart';

class ShopList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ShopListState();
}

class ShopListState extends State<ShopList> {
  List _shops = [];
  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() {
    HairApi.getShops({}).then((value) {
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
      Shop shopModel = Provider.of<ShopModel>(context).shop;
      bool checked = shopModel != null;
      return Scaffold(
        appBar: AppBar(
          title: Text('${checked ? '店铺列表' : '请选择店铺'}'),
          centerTitle: true,
          actions: [
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => ShopEdit()))
                      .then((value) {
                    if (value == true) {
                      _init();
                    }
                  });
                })
          ],
        ),
        body: ListView.builder(
          itemCount: _shops.length,
          itemBuilder: (BuildContext context, int index) {
            Map<String, dynamic> shop = new Map.from(_shops[index]);
            bool _selected = shopModel != null && shopModel.id == shop['id'];
            return ListTile(
              onTap: () {
                Provider.of<ShopModel>(context, listen: false).shop =
                    Shop.fromJson(shop);
              },
              leading: Icon(_selected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked),
              selected: _selected,
              title: Text(shop['name']),
              subtitle: Text(DateFormat('yyyy-MM-dd').format(
                  DateTime.fromMillisecondsSinceEpoch(shop['ctime'] * 1000))),
              trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(
                            builder: (context) => ShopEdit(id: shop['id'])))
                        .then((value) {
                      if (value == true) {
                        _init();
                      }
                    });
                  }),
            );
          },
        ),
      );
    }
  }
}

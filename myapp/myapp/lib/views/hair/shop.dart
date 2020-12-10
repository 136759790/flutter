import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/api/hair.dart';
import 'package:myapp/common/Page.dart';
import 'package:myapp/common/notifier.dart';
import 'package:myapp/models/hair/card.dart';
import 'package:myapp/models/shop.dart';
import 'package:myapp/views/hair/card_edit.dart';
import 'package:myapp/views/hair/card_view.dart';
import 'package:myapp/views/hair/shop_search.dart';
import 'package:provider/provider.dart';

class HairShop extends StatefulWidget {
  HairShop({Key key}) : super(key: key);

  @override
  _HairShopState createState() => _HairShopState();
}

class _HairShopState extends State<HairShop> {
  @override
  Widget build(BuildContext context) {
    Shop shop = Provider.of<ShopModel>(context).shop;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer()),
          title: Text('${shop.name}'),
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
                .push(MaterialPageRoute(builder: (context) => ShopCard()))
                .then((value) {
              if (value) {
                setState(() {});
              }
            });
          },
          heroTag: "addCard",
        ),
      ),
    );
  }

  Widget _body() {
    var data = {
      'shop_id': Provider.of<ShopModel>(context, listen: false).shop.id
    };
    return FutureBuilder(
        future: HairApi.getCards(data),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            PageInfo page = snapshot.data;
            List cards = page.data;
            if (page == null || page.data == null || page.data.isEmpty) {
              return Center(child: Text('没有数据'));
            } else {
              return Column(
                children: [
                  Expanded(
                      child: Row(
                    children: [
                      Expanded(
                          child: Card(
                        child: ListTile(
                          title: Text('会员卡数量'),
                          subtitle: Text('${page.total}'),
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
                              delegate:
                                  SliverChildBuilderDelegate((context, index) {
                            List cards = page.data;
                            HairCard card = HairCard.fromJson(cards[index]);
                            return Column(children: [
                              ListTile(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => CardView(card.id)));
                                },
                                title: Text(
                                  "${card.name}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Row(
                                  children: [
                                    Chip(
                                      avatar: Icon(Icons.person),
                                      label: Text('${card.vip.name}'),
                                    ),
                                    Chip(
                                      avatar: Icon(Icons.phone),
                                      label: Text('${card.vip.phone}'),
                                    ),
                                  ],
                                ),
                                trailing:
                                    Text('剩余次数：${card.residue_time ?? 0}'),
                              ),
                              Divider()
                            ]);
                          }, childCount: page.data.length)),
                        ))
                      ],
                    ),
                    flex: 5,
                  )
                ],
              );
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Future<bool> _onWillPop() {
    showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }
}

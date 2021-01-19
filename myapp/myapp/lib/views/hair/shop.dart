import 'package:azlistview/azlistview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/api/hair.dart';
import 'package:myapp/common/notifier.dart';
import 'package:myapp/common/route.dart';
import 'package:myapp/models/hair/vip.dart';
import 'package:myapp/models/shop.dart';
import 'package:myapp/routes/login.dart';
import 'package:myapp/views/hair/shop_list.dart';
import 'package:myapp/views/hair/vip_edit.dart';
import 'package:myapp/views/hair/vip_search.dart';
import 'package:myapp/views/hair/vip_view.dart';
import 'package:provider/provider.dart';

class HairShop extends StatefulWidget {
  HairShop({Key key}) : super(key: key);

  @override
  _HairShopState createState() => _HairShopState();
}

class _HairShopState extends State<HairShop>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    print('intintintinitntint');
  }

  @override
  Widget build(BuildContext context) {
    ShopModel shopm = Provider.of<ShopModel>(context, listen: false);
    if (shopm == null || shopm.shop == null) {
      Rt.toDelay(context, ShopList());
      return Center(
        child: Text('即将跳转到店铺选择页面。。。'),
      );
    } else {
      Shop shop = shopm.shop;
      String shop_name = shop == null ? '店铺' : shop.name;
      return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openDrawer()),
            title: Text('$shop_name'),
            centerTitle: true,
            actions: [
              IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    // showSearch(context: context, delegate: SearchBarShop());
                    showSearch(context: context, delegate: VipSearch());
                  })
            ],
          ),
          body: _body(),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Rt.to(context, VipEdit());
            },
            heroTag: "addVip",
          ),
        ),
      );
    }
  }

  Future<List<Vip>> _getVips(var data) async {
    List<Vip> vips = await HairApi.getVips(data);
    return vips;
  }

  Widget _body() {
    Shop shop = Provider.of<ShopModel>(context, listen: false).shop;
    var data = {'shop_id': shop != null ? shop.id : null};
    return RefreshIndicator(
      onRefresh: () async {
        _getVips(data);
      },
      child: FutureBuilder(
          future: _getVips(data),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              List<Vip> vips = snapshot.data;
              SuspensionUtil.setShowSuspensionStatus(vips);
              if (vips == null || vips.isEmpty) {
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
                            title: Text('会员数量${vips.length}'),
                          ),
                        )),
                        Expanded(
                            child: Card(
                          child: ListTile(
                            title: Text('今日新增'),
                          ),
                        )),
                      ],
                    )),
                    Expanded(
                      child: AzListView(
                          physics: BouncingScrollPhysics(),
                          indexBarData: SuspensionUtil.getTagIndexList(vips),
                          indexHintBuilder: (context, hint) {
                            return Container(
                              alignment: Alignment.center,
                              width: 60.0,
                              height: 60.0,
                              decoration: BoxDecoration(
                                color: Colors.blue[700].withAlpha(200),
                                shape: BoxShape.circle,
                              ),
                              child: Text(hint,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 30.0)),
                            );
                          },
                          indexBarMargin: EdgeInsets.all(10),
                          indexBarOptions: IndexBarOptions(
                            needRebuild: true,
                            decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(20.0),
                                border: Border.all(
                                    color: Colors.grey[300], width: .5)),
                            downDecoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(20.0),
                                border: Border.all(
                                    color: Colors.grey[300], width: .5)),
                          ),
                          data: vips,
                          itemCount: vips.length,
                          itemBuilder: (context, index) {
                            return _buildListItem(vips[index]);
                          }),
                      flex: 6,
                    )
                  ],
                );
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  Widget _buildListItem(Vip vip) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            child: Text(
              vip.name[0],
            ),
          ),
          title: Text('${vip.name}(${vip.phone})'),
          onTap: () {
            Rt.to(context, VipView(vip.id))
                .then((value) => {this.setState(() {})});
          },
        ),
      ],
    );
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
    ).then((value) {});
  }

  @override
  bool get wantKeepAlive => true;
}

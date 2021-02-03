import 'package:azlistview/azlistview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/api/hair.dart';
import 'package:myapp/common/notifier.dart';
import 'package:myapp/common/route.dart';
import 'package:myapp/common/state/httpWidget.dart';
import 'package:myapp/common/state/manager.dart';
import 'package:myapp/models/hair/vip.dart';
import 'package:myapp/models/shop.dart';
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
  StatusManager smanager;
  @override
  void initState() {
    super.initState();
    smanager = StatusManager();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer()),
          title: Text('会员列表'),
          centerTitle: true,
          actions: [
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  showSearch(context: context, delegate: VipSearch());
                })
          ],
        ),
        body: HttpWidget<List<Vip>>(
          controller: smanager.controller,
          httpBuilder: (context, t) {
            return _body(t);
          },
        ),
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

  Future<List<Vip>> _getVips() async {
    var data = {
      'shop_id': Provider.of<ShopModel>(context, listen: false).shop.id
    };
    List<Vip> vips = await HairApi.getVips(data);
    return vips;
  }

  Widget _body(List<Vip> vips) {
    SuspensionUtil.setShowSuspensionStatus(vips);
    if (vips == null || vips.isEmpty) {
      return Center(child: Text('没有数据'));
    } else {
      return Container(
        padding: EdgeInsets.fromLTRB(5, 20, 5, 0),
        child: Column(
          children: [
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
                          style:
                              TextStyle(color: Colors.white, fontSize: 30.0)),
                    );
                  },
                  indexBarMargin: EdgeInsets.all(10),
                  indexBarOptions: IndexBarOptions(
                    needRebuild: true,
                    decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(color: Colors.grey[300], width: .5)),
                    downDecoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(color: Colors.grey[300], width: .5)),
                  ),
                  data: vips,
                  itemCount: vips.length,
                  itemBuilder: (context, index) {
                    return _buildListItem(vips[index]);
                  }),
              flex: 6,
            )
          ],
        ),
      );
    }
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
        title: new Text('提示'),
        content: new Text('确定要退出应用？'),
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

  void _loadData() {
    print(999999999999999);
    ShopModel shopModel = Provider.of<ShopModel>(context, listen: false);
    Shop shop = null;
    if (shopModel == null) {
      Rt.toDelay(context, ShopList());
    } else {
      shop = shopModel.shop;
      if (shop == null) {
        Rt.toDelay(context, ShopList());
      } else {
        smanager.loading();
        _getVips().then((value) {
          smanager.success(value);
        }).catchError((e) {
          smanager.error();
        });
      }
    }
  }

  @override
  bool get wantKeepAlive => true;
}

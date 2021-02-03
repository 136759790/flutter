import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/common/notifier.dart';
import 'package:myapp/common/route.dart';
import 'package:myapp/models/user.dart';
import 'package:myapp/routes/login.dart';
import 'package:myapp/views/hair/shop_list.dart';
import 'package:provider/provider.dart';

class MineRoute extends StatefulWidget {
  MineRoute({Key key}) : super(key: key);

  @override
  _MineRouteState createState() => _MineRouteState();
}

class _MineRouteState extends State<MineRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的信息'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: _body(),
    );
  }

  Widget _body() {
    User user = Provider.of<UserNotifier>(context, listen: false).user;
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.people),
            dense: true,
            title: Text('帐号：'),
            trailing: Text('${user.account}'),
          ),
          Divider(
            height: 1,
          ),
          ListTile(
            leading: Icon(Icons.email_outlined),
            dense: true,
            title: Text('邮箱：'),
            trailing: Text('${user.email}'),
          ),
          Divider(
            height: 1,
          ),
          ListTile(
            leading: Icon(Icons.phone),
            dense: true,
            title: Text('手机：'),
            trailing: Text('${user.phone}'),
          ),
          Divider(
            height: 1,
          ),
          ListTile(
            leading: Icon(Icons.switch_left),
            dense: true,
            title: Text('切换店铺'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Rt.toDelay(context, ShopList());
            },
          ),
          Divider(
            height: 1,
          ),
          Container(
            padding: EdgeInsets.all(20),
            width: 1000,
            child: RaisedButton(
              onPressed: () {
                Rt.toDelay(context, LoginRoute());
              },
              child: Text('切换账号'),
              color: Theme.of(context).primaryColor,
            ),
          )
        ],
      ),
    );
  }
}

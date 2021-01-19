import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/common/notifier.dart';
import 'package:myapp/models/user.dart';
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
            title: Text('姓名：'),
            trailing: Text('${user.name}'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.phone),
            dense: true,
            title: Text('手机：'),
            trailing: Text('${user.phone}'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.clear),
            dense: true,
            title: Text('清除店铺'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Provider.of<ShopModel>(context, listen: false).clear();
            },
          ),
        ],
      ),
    );
  }
}

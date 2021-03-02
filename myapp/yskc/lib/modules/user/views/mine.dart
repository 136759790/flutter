import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yskc/common/dialog.dart';
import 'package:yskc/common/http.dart';
import 'package:yskc/common/notifier.dart';
import 'package:provider/provider.dart';
import 'package:yskc/common/route.dart';
import 'package:yskc/modules/user/model/user.dart';
import 'package:yskc/routes/home.dart';
import 'package:yskc/routes/login.dart';

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
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
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
            onTap: () {},
          ),
          Divider(),
          Container(
            padding: EdgeInsets.all(20),
            width: 1000,
            child: RaisedButton(
              onPressed: () async {
                await Dr.show(context, "确认要退出吗？").then((value) => {cookieJar.deleteAll()});
                Navigator.of(context)..pushNamedAndRemoveUntil('login', (route) => route == HomeRoute());
              },
              child: Text('退出登录'),
              color: Theme.of(context).primaryColor,
            ),
          )
        ],
      ),
    );
  }
}

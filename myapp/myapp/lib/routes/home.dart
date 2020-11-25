import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:myapp/api/user.dart';
import 'package:myapp/common/global.dart';
import 'package:myapp/common/notifier.dart';
import 'package:myapp/common/result.dart';
import 'package:myapp/main/btnAdd.dart';
import 'package:myapp/main/drawer.dart';
import 'package:myapp/main/mainAccount.dart';
import 'package:myapp/models/project.dart';
import 'package:myapp/models/shop.dart';
import 'package:myapp/models/user.dart';
import 'package:myapp/routes/login.dart';
import 'package:myapp/views/hair/shop.dart';
import 'package:myapp/views/hair/shop_list.dart';
import 'package:myapp/widgets/switch_project.dart';
import 'package:provider/provider.dart';

class HomeRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  int _currentIndex = 0;
  String status = "unlogin"; //unlogin,unshop,unproject
  StatefulWidget _currentPage = AccountMain();
  _onTap(int index) {
    switch (index) {
      case 0:
        _currentPage = AccountMain();
        break;
      case 1:
        _currentPage = HairShop();
        break;
    }
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _check(context),
      builder: (context, snapshot) {
        print('renderrenderrenderrenderrenderrenderrenderrenderrender');
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data == "unlogin") {
            return LoginRoute();
          } else if (snapshot.data == "unshop") {
            return ShopList();
          } else {
            return Scaffold(
                body: _currentPage,
                // floatingActionButton: BtnAdd(),
                drawer: DrawerWidget(),
                bottomNavigationBar: BottomNavigationBar(
                  currentIndex: this._currentIndex,
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home), title: Text('首页')),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.book), title: Text('会员卡')),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.music_note), title: Text('理发')),
                  ],
                  onTap: _onTap,
                ));
          }
        } else {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.greenAccent.shade700,
            ),
          );
        }
      },
    );
  }
}

Future<String> _check(BuildContext context) async {
  User user = Provider.of<UserNotifier>(context, listen: false).user;
  if (user == null) {
    return "unlogin";
  } else {
    if (user.account == null || user.password == null) {
      return "unlogin";
    } else {
      bool isLogin = await UserApi.isLogin();
      if (!isLogin) {
        UserApi.login(user.account, user.password).then((data) {
          if (data.status != 1) {
            return "unlogin";
          } else {
            Provider.of<UserNotifier>(context, listen: false).user =
                User.fromJson(new Map.from(data.data));
          }
        });
      }
    }
  }
  ShopModel shopModel = Provider.of<ShopModel>(context, listen: false);
  if (shopModel == null || shopModel.shop == null) {
    return "unshop";
  } else {
    return "ok";
  }
}

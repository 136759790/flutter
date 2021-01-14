import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/api/user.dart';
import 'package:myapp/common/notifier.dart';
import 'package:myapp/common/route.dart';
import 'package:myapp/main/drawer.dart';
import 'package:myapp/models/user.dart';
import 'package:myapp/routes/login.dart';
import 'package:myapp/views/hair/set_list.dart';
import 'package:myapp/views/hair/shop.dart';
import 'package:myapp/views/hair/shop_list.dart';
import 'package:provider/provider.dart';

class HomeRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  String status = "unlogin"; //unlogin,unshop,unproject

  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  String status = "unlogin"; //unlogin,unshop,unproject
  StatefulWidget _currentPage = HairShop();
  _onTap(int index) {
    switch (index) {
      case 0:
        _currentPage = HairShop();
        break;
      case 1:
        _currentPage = SetList();
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
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
                child: Scaffold(
                    body: _currentPage,
                    drawer: DrawerWidget(),
                    bottomNavigationBar: BottomNavigationBar(
                      currentIndex: this._currentIndex,
                      items: [
                        BottomNavigationBarItem(
                            icon: Icon(Icons.account_circle_outlined),
                            title: Text('会员')),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.card_giftcard), title: Text('套餐')),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.person), title: Text('我的')),
                      ],
                      onTap: _onTap,
                    )));
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Future<String> _check(BuildContext context) async {
    User user = Provider.of<UserNotifier>(context, listen: false).user;
    var login = LoginRoute();
    var shop = ShopList();
    if (user == null) {
      Rt.to(context, login);
    } else {
      if (user.account == null || user.password == null) {
        Rt.to(context, login);
      } else {
        bool isLogin = await UserApi.isLogin();
        if (!isLogin) {
          var res = await UserApi.login(user.account, user.password);
          if (res.data.status != 1) {
            Rt.to(context, login);
          } else {
            Provider.of<UserNotifier>(context, listen: false).user =
                User.fromJson(new Map.from(res.data));
          }
        }
      }
    }
    ShopModel shopModel = Provider.of<ShopModel>(context, listen: false);
    if (shopModel == null || shopModel.shop == null) {
      Rt.to(context, shop);
    }
    return "ok";
  }
}

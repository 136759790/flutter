import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/api/user.dart';
import 'package:myapp/common/global.dart';
import 'package:myapp/common/notifier.dart';
import 'package:myapp/main/bottomNav.dart';
import 'package:myapp/main/btnAdd.dart';
import 'package:myapp/main/drawer.dart';
import 'package:myapp/main/mainAccount.dart';
import 'package:myapp/models/user.dart';
import 'package:provider/provider.dart';

class HomeRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _login(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          print(snapshot.toString());
          if (snapshot.hasData) {
            print(snapshot.data);
            Navigator.pushNamed(context, 'login');
          } else {
            print('111111111111111');
            return Scaffold(
                body: AccountMain(),
                floatingActionButton: BtnAdd(),
                drawer: MainDrawer(),
                bottomNavigationBar: MainBottomNav());
          }
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}

Future<bool> _login() async {
  bool isLogin = await UserApi.isLogin();
  if (!isLogin) {
    User user = Global.profile.user;
    if (user == null || user.username == null || user.password == null) {
      return false;
    } else {
      return await UserApi.login(user.username, user.password);
    }
  } else {
    return true;
  }
}

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/api/user.dart';
import 'package:myapp/common/notifier.dart';
import 'package:myapp/common/result.dart';
import 'package:myapp/main/bottomNav.dart';
import 'package:myapp/main/btnAdd.dart';
import 'package:myapp/main/drawer.dart';
import 'package:myapp/main/mainAccount.dart';
import 'package:myapp/models/user.dart';
import 'package:myapp/routes/login.dart';
import 'package:provider/provider.dart';

class HomeRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _login(Provider.of<UserModel>(context).user),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          print(snapshot.toString());
          if (!snapshot.hasData) {
            return LoginRoute();
          } else {
            return Scaffold(
                body: AccountMain(),
                floatingActionButton: BtnAdd(),
                drawer: MainDrawer(),
                bottomNavigationBar: MainBottomNav());
          }
        } else {
          return SizedBox(
            height: 3,
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

Future _login(User user) async {
  bool isLogin = await UserApi.isLogin();
  if (!isLogin) {
    if (user == null || user.username == null || user.password == null) {
      return false;
    } else {
      Result result = await UserApi.login(user.username, user.password);
      return result.status == 1;
    }
  } else {
    return true;
  }
}

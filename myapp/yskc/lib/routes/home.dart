import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:yskc/api/user.dart';
import 'package:yskc/common/global.dart';
import 'package:yskc/common/notifier.dart';
import 'package:yskc/common/result.dart';
import 'package:yskc/main/bottomNav.dart';
import 'package:yskc/main/btnAdd.dart';
import 'package:yskc/main/drawer.dart';
import 'package:yskc/models/project.dart';
import 'package:yskc/models/user.dart';
import 'package:yskc/routes/login.dart';
import 'package:yskc/views/truck/truck.dart';
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
          if (!snapshot.data) {
            return LoginRoute();
          } else {
            return Scaffold(
                body: TruckList(),
                floatingActionButton: BtnAdd(),
                drawer: DrawerWidget(),
                bottomNavigationBar: MainBottomNav());
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

Future _login() async {
  bool isLogin = await UserApi.isLogin();
  if (!isLogin) {
    String userInfo = Hive.box(Global.CONFIG).get('user');
    print('object---->$userInfo');
    if (userInfo == null || userInfo.isEmpty) {
      return false;
    }
    User user = User.fromJson(json.decode(userInfo));
    print(user.toString());
    if (user.account == null || user.password == null) {
      return false;
    } else {
      Result result = await UserApi.login(user.account, user.password);
      return result.status == 1;
    }
  } else {
    return true;
  }
}

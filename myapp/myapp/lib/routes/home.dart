import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:myapp/api/user.dart';
import 'package:myapp/common/global.dart';
import 'package:myapp/common/notifier.dart';
import 'package:myapp/common/result.dart';
import 'package:myapp/main/bottomNav.dart';
import 'package:myapp/main/btnAdd.dart';
import 'package:myapp/main/drawer.dart';
import 'package:myapp/main/mainAccount.dart';
import 'package:myapp/models/project.dart';
import 'package:myapp/models/user.dart';
import 'package:myapp/routes/login.dart';
import 'package:myapp/widgets/switch_project.dart';
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
          Project project = Provider.of<ProjectModel>(context).project;
          if (!snapshot.data) {
            return LoginRoute();
          } else if (project == null) {
            return SwitchProject();
          } else {
            return Scaffold(
                body: AccountMain(),
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

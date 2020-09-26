import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/main/bottomNav.dart';
import 'package:myapp/main/btnAdd.dart';
import 'package:myapp/main/drawer.dart';
import 'package:myapp/main/mainAccount.dart';

class HomeRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AccountMain(),
        floatingActionButton: BtnAdd(),
        drawer: MainDrawer(),
        bottomNavigationBar: MainBottomNav());
  }
}

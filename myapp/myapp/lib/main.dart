import 'package:flutter/material.dart';
import 'package:myapp/main/accounts.dart';
import 'package:myapp/main/bottomNav.dart';
import 'package:myapp/main/drawer.dart';
import 'package:myapp/main/mainAccount.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '小店',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
            body: AccountMain(),
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              child: Icon(Icons.add),
            ),
            drawer: MainDrawer(),
            bottomNavigationBar: MainBottomNav()));
  }
}

import 'package:flutter/material.dart';
import 'package:myapp/main/accounts.dart';
import 'package:myapp/main/bottomNav.dart';
import 'package:myapp/main/drawer.dart';

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
            appBar: AppBar(
              title: Text('小店'),
            ),
            body: ExpandAccounts(),
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              child: Text('+'),
            ),
            drawer: MainDrawer(),
            bottomNavigationBar: MainBottomNav()));
  }
}

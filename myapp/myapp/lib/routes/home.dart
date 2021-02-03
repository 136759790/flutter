import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/main/drawer.dart';
import 'package:myapp/views/hair/mine.dart';
import 'package:myapp/views/hair/set_list.dart';
import 'package:myapp/views/hair/shop.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) {
    print('init-------homepage');
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pagecontroller = PageController();
  int _currentIndex = 0;
  List<Widget> _bodyList = [HairShop(), SetList(), MineRoute()];
  _onTap(int index) {
    if (index == _currentIndex) {
      return;
    }
    _pagecontroller.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    print('homehomehomehomehomehomehome');
    return Container(
        child: Scaffold(
            body: PageView(
              controller: _pagecontroller,
              children: _bodyList,
              onPageChanged: _onPageChanged,
              physics: NeverScrollableScrollPhysics(),
            ),
            drawer: DrawerWidget(),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: this._currentIndex,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle_outlined),
                    title: Text('会员')),
                BottomNavigationBarItem(
                    icon: Icon(Icons.category), title: Text('套餐')),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), title: Text('我的')),
              ],
              onTap: _onTap,
            )));
  }

  _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

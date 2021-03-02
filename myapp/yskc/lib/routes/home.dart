import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yskc/modules/truck/views/list.dart';
import 'package:yskc/modules/user/views/mine.dart';

class HomeRoute extends StatefulWidget {
  HomeRoute({Key key}) : super(key: key);

  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  final _pagecontroller = PageController();
  int _currentIndex = 0;
  List<Widget> _bodyList = [TruckList(), TruckList(), MineRoute()];
  _onTap(int index) {
    if (index == _currentIndex) {
      return;
    }
    _pagecontroller.jumpToPage(index);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
            body: PageView(
              controller: _pagecontroller,
              children: _bodyList,
              onPageChanged: _onPageChanged,
              physics: NeverScrollableScrollPhysics(),
            ),
            drawer: Drawer(),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: this._currentIndex,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined), label: '会员'),
                BottomNavigationBarItem(icon: Icon(Icons.category), label: '套餐'),
                BottomNavigationBarItem(icon: Icon(Icons.person), label: '我的'),
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

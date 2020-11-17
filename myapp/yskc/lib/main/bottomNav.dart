import 'package:flutter/material.dart';

class MainBottomNav extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainBottomNavState();
  }
}

class MainBottomNavState extends State<MainBottomNav> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: this.currentIndex,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: '车源'),
        BottomNavigationBarItem(icon: Icon(Icons.book), label: '求购'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: '我的'),
      ],
      onTap: (int index) {
        setState(() {
          this.currentIndex = index;
        });
      },
    );
  }
}

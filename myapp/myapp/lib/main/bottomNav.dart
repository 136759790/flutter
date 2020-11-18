import 'package:flutter/material.dart';

class MainBottomNav extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainBottomNavState();
  }
}

class MainBottomNavState extends State<MainBottomNav> {
  int currentIndex = 0;
  StatefulWidget _currentPage;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: this.currentIndex,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
        BottomNavigationBarItem(icon: Icon(Icons.book), label: '店铺'),
        BottomNavigationBarItem(icon: Icon(Icons.music_note), label: '音乐'),
      ],
      onTap: (int index) {
        setState(() {
          this.currentIndex = index;
        });
      },
    );
  }
}

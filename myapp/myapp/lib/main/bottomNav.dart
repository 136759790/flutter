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
        BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('首页')),
        BottomNavigationBarItem(icon: Icon(Icons.book), title: Text('小说')),
        BottomNavigationBarItem(
            icon: Icon(Icons.music_note), title: Text('音乐')),
      ],
      onTap: (int index) {
        setState(() {
          this.currentIndex = index;
        });
      },
    );
  }
}

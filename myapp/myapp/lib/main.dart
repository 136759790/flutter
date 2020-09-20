import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text('元氏卡车'),
          ),
          body: Center(
            child: Text('hello world'),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: Text('+'),
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.all(0),
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text('赵晓腾'),
                  accountEmail: Text('136759790@qq.com'),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://avatars1.githubusercontent.com/u/18189078?s=400&u=f755a948031cb7e756b661c9f7c0978ed8524b96&v=4'),
                  ),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://avatars1.githubusercontent.com/u/18189078?s=400&u=f755a948031cb7e756b661c9f7c0978ed8524b96&v=4'))),
                ),
                ListTile(title: Text('用户反馈'), trailing: Icon(Icons.feedback)),
                ListTile(title: Text('系统设置'), trailing: Icon(Icons.settings)),
                ListTile(title: Text('我要发布'), trailing: Icon(Icons.send)),
                Divider(),
                ListTile(title: Text('注销'), trailing: Icon(Icons.exit_to_app)),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), title: Text('首页')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.history), title: Text('卡车')),
            ],
            onTap: (int index) {},
          ),
        ));
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/common/notifier.dart';
import 'package:provider/provider.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(0),
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              '${Provider.of<UserModel>(context).user.username}',
              style: TextStyle(color: Colors.black),
            ),
            accountEmail: Text(
              '136759790@qq.com',
              style: TextStyle(color: Colors.black),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://avatars1.githubusercontent.com/u/18189078?s=400&u=f755a948031cb7e756b661c9f7c0978ed8524b96&v=4'),
            ),
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/bg_flower.jpg'))),
          ),
          ListTile(title: Text('用户反馈'), trailing: Icon(Icons.feedback)),
          ListTile(title: Text('系统设置'), trailing: Icon(Icons.settings)),
          ListTile(title: Text('我要发布'), trailing: Icon(Icons.send)),
          Divider(),
          ListTile(
            title: Text('切换账号'),
            trailing: Icon(Icons.exit_to_app),
            onTap: () {
              Navigator.pushNamed(context, 'login');
            },
          ),
        ],
      ),
    );
  }
}
